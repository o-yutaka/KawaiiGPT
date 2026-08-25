-- NEAR operations: moderation/audit/feature flags.

begin;

create table if not exists public.moderation_events (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references auth.users(id) on delete set null,
  target_id uuid references auth.users(id) on delete set null,
  action text not null,
  reason text not null default '',
  metadata jsonb not null default '{}',
  created_at timestamptz not null default now()
);

create table if not exists public.feature_flags (
  key text primary key,
  enabled boolean not null default false,
  config jsonb not null default '{}',
  updated_at timestamptz not null default now()
);

create table if not exists public.audit_events (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references auth.users(id) on delete set null,
  event_name text not null,
  entity_type text,
  entity_id uuid,
  metadata jsonb not null default '{}',
  created_at timestamptz not null default now()
);

alter table public.moderation_events enable row level security;
alter table public.feature_flags enable row level security;
alter table public.audit_events enable row level security;

revoke all on public.moderation_events from public, anon, authenticated;
revoke all on public.audit_events from public, anon, authenticated;
revoke all on public.feature_flags from public, anon;
grant select on public.feature_flags to authenticated;

drop policy if exists feature_flags_read on public.feature_flags;
create policy feature_flags_read on public.feature_flags for select to authenticated using (true);

commit;
