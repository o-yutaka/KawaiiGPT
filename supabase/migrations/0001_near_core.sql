-- NEAR Core v0.1
-- Docker-free target: Supabase Cloud.
-- Raw coordinates are private server data only. Public discovery returns area/activity data.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null check (char_length(display_name) between 1 and 40),
  age smallint check (age is null or age between 18 and 120),
  bio text not null default '',
  interests text[] not null default '{}',
  avatar_path text,
  verified boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.location_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  latitude double precision not null check (latitude between -90 and 90),
  longitude double precision not null check (longitude between -180 and 180),
  accuracy_m double precision,
  captured_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '15 minutes')
);
create index if not exists idx_location_sessions_user_time on public.location_sessions(user_id, captured_at desc);
create index if not exists idx_location_sessions_expiry on public.location_sessions(expires_at);

create table if not exists public.conversations (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now()
);

create table if not exists public.conversation_members (
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  joined_at timestamptz not null default now(),
  primary key (conversation_id, user_id)
);

create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  sender_id uuid not null references auth.users(id) on delete cascade,
  body text not null check (char_length(body) between 1 and 4000),
  created_at timestamptz not null default now(),
  edited_at timestamptz
);
create index if not exists idx_messages_conversation_time on public.messages(conversation_id, created_at desc);

create table if not exists public.now_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  area_label text not null,
  body text not null check (char_length(body) between 1 and 500),
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '24 hours')
);
create index if not exists idx_now_posts_expiry on public.now_posts(expires_at);

create table if not exists public.connection_requests (
  id uuid primary key default gen_random_uuid(),
  requester_id uuid not null references auth.users(id) on delete cascade,
  target_id uuid not null references auth.users(id) on delete cascade,
  status text not null default 'pending' check (status in ('pending','accepted','rejected','cancelled')),
  created_at timestamptz not null default now(),
  responded_at timestamptz,
  check (requester_id <> target_id)
);
create unique index if not exists ux_connection_pair on public.connection_requests(least(requester_id, target_id), greatest(requester_id, target_id)) where status in ('pending','accepted');

create table if not exists public.blocks (
  blocker_id uuid not null references auth.users(id) on delete cascade,
  blocked_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (blocker_id, blocked_id),
  check (blocker_id <> blocked_id)
);

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  reporter_id uuid not null references auth.users(id) on delete cascade,
  target_id uuid not null references auth.users(id) on delete cascade,
  category text not null,
  note text not null default '',
  created_at timestamptz not null default now(),
  status text not null default 'open' check (status in ('open','reviewing','resolved','dismissed'))
);

create table if not exists public.analytics_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,
  event_name text not null,
  payload jsonb not null default '{}',
  created_at timestamptz not null default now()
);

-- Public discovery view deliberately excludes latitude/longitude.
create or replace view public.public_near_profiles as
select
  p.user_id,
  p.display_name,
  p.age,
  p.bio,
  p.interests,
  p.avatar_path,
  p.verified
from public.profiles p;

alter table public.profiles enable row level security;
alter table public.location_sessions enable row level security;
alter table public.conversations enable row level security;
alter table public.conversation_members enable row level security;
alter table public.messages enable row level security;
alter table public.now_posts enable row level security;
alter table public.connection_requests enable row level security;
alter table public.blocks enable row level security;
alter table public.reports enable row level security;
alter table public.analytics_events enable row level security;

-- Profiles: public-safe fields may be read by authenticated users; writes are owner-only.
drop policy if exists profiles_select_authenticated on public.profiles;
create policy profiles_select_authenticated on public.profiles for select to authenticated using (true);
drop policy if exists profiles_insert_self on public.profiles;
create policy profiles_insert_self on public.profiles for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists profiles_update_self on public.profiles;
create policy profiles_update_self on public.profiles for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Raw location: deny client reads. Only the server-side service role may read/write it.
revoke all on public.location_sessions from anon, authenticated;
grant select, insert, update, delete on public.location_sessions to service_role;

-- Conversations.
drop policy if exists conversation_members_select_self on public.conversation_members;
create policy conversation_members_select_self on public.conversation_members for select to authenticated using (auth.uid() = user_id);
drop policy if exists conversations_select_member on public.conversations;
create policy conversations_select_member on public.conversations for select to authenticated using (exists (select 1 from public.conversation_members cm where cm.conversation_id = id and cm.user_id = auth.uid()));
drop policy if exists messages_select_member on public.messages;
create policy messages_select_member on public.messages for select to authenticated using (exists (select 1 from public.conversation_members cm where cm.conversation_id = messages.conversation_id and cm.user_id = auth.uid()));
drop policy if exists messages_insert_self on public.messages;
create policy messages_insert_self on public.messages for insert to authenticated with check (auth.uid() = sender_id and exists (select 1 from public.conversation_members cm where cm.conversation_id = messages.conversation_id and cm.user_id = auth.uid()));

-- NOW: authenticated users may read non-expired posts and create/update their own.
drop policy if exists now_select_authenticated on public.now_posts;
create policy now_select_authenticated on public.now_posts for select to authenticated using (expires_at > now());
drop policy if exists now_insert_self on public.now_posts;
create policy now_insert_self on public.now_posts for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists now_update_self on public.now_posts;
create policy now_update_self on public.now_posts for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Connections, blocks, reports.
drop policy if exists connection_select_party on public.connection_requests;
create policy connection_select_party on public.connection_requests for select to authenticated using (auth.uid() in (requester_id, target_id));
drop policy if exists connection_insert_self on public.connection_requests;
create policy connection_insert_self on public.connection_requests for insert to authenticated with check (auth.uid() = requester_id and requester_id <> target_id);
drop policy if exists block_select_self on public.blocks;
create policy block_select_self on public.blocks for select to authenticated using (auth.uid() = blocker_id);
drop policy if exists block_insert_self on public.blocks;
create policy block_insert_self on public.blocks for insert to authenticated with check (auth.uid() = blocker_id and blocker_id <> blocked_id);
drop policy if exists report_insert_self on public.reports;
create policy report_insert_self on public.reports for insert to authenticated with check (auth.uid() = reporter_id);

-- Analytics: users can append their own events, but not read raw analytics.
drop policy if exists analytics_insert_self on public.analytics_events;
create policy analytics_insert_self on public.analytics_events for insert to authenticated with check (auth.uid() = user_id);
revoke select on public.analytics_events from anon, authenticated;
revoke all on public.reports from anon, authenticated;
grant insert on public.reports to authenticated;

-- Prevent accidental coordinate exposure through broad client grants.
revoke all on public.location_sessions from anon, authenticated;
revoke all on public.location_sessions from public;
