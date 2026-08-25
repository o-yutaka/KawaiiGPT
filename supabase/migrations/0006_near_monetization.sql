-- NEAR monetization primitives.

begin;

create table if not exists public.subscriptions (
  user_id uuid primary key references auth.users(id) on delete cascade,
  entitlement text not null default 'free' check (entitlement in ('free','plus','premium')),
  provider text,
  external_customer_id text,
  external_subscription_id text,
  current_period_end timestamptz,
  updated_at timestamptz not null default now()
);

create table if not exists public.affiliate_offers (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  destination text not null,
  disclosure text not null default 'Affiliate',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.affiliate_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,
  offer_id uuid references public.affiliate_offers(id) on delete set null,
  event_type text not null check (event_type in ('impression','click','conversion')),
  attribution_id text,
  metadata jsonb not null default '{}',
  created_at timestamptz not null default now()
);

create table if not exists public.sponsored_campaigns (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  area_label text,
  active boolean not null default false,
  starts_at timestamptz,
  ends_at timestamptz,
  metadata jsonb not null default '{}',
  created_at timestamptz not null default now()
);

alter table public.subscriptions enable row level security;
alter table public.affiliate_offers enable row level security;
alter table public.affiliate_events enable row level security;
alter table public.sponsored_campaigns enable row level security;

drop policy if exists subscription_self_read on public.subscriptions;
create policy subscription_self_read on public.subscriptions for select to authenticated using (auth.uid() = user_id);

revoke all on public.affiliate_events from public, anon, authenticated;
revoke all on public.sponsored_campaigns from public, anon, authenticated;

drop policy if exists affiliate_offer_read on public.affiliate_offers;
create policy affiliate_offer_read on public.affiliate_offers for select to authenticated using (active = true);

commit;
