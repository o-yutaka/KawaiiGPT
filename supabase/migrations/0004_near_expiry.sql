-- NEAR Wave 2: automatic cleanup of expired location sessions and NOW posts.

begin;

create or replace function public.near_cleanup_expired()
returns void
language sql
security definer
set search_path = public
as $$
  delete from public.location_sessions where expires_at <= now();
  delete from public.now_posts where expires_at <= now();
$$;

revoke all on function public.near_cleanup_expired() from public, anon, authenticated;
grant execute on function public.near_cleanup_expired() to service_role;

commit;
