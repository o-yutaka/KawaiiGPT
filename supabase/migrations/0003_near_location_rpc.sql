-- NEAR Wave 2: server-side proximity contract.
-- Clients never receive raw latitude/longitude.

begin;

create or replace function public.nearby_users(
  p_lat double precision,
  p_lon double precision,
  p_radius_m integer default 1000,
  p_limit integer default 50
)
returns table (
  user_id uuid,
  distance_m integer,
  activity text,
  recent_label text
)
language sql
security definer
set search_path = public
as $$
  with latest as (
    select distinct on (ls.user_id)
      ls.user_id,
      ls.latitude,
      ls.longitude,
      ls.captured_at
    from public.location_sessions ls
    where ls.expires_at > now()
    order by ls.user_id, ls.captured_at desc
  ),
  measured as (
    select
      l.user_id,
      round((6371000.0 * 2.0 * asin(sqrt(
        power(sin(radians(l.latitude - p_lat) / 2), 2) +
        cos(radians(p_lat)) * cos(radians(l.latitude)) *
        power(sin(radians(l.longitude - p_lon) / 2), 2)
      ))))::integer as distance_m,
      l.captured_at
    from latest l
  )
  select
    m.user_id,
    m.distance_m,
    case
      when extract(epoch from (now() - m.captured_at)) < 120 then 'LIVE'
      when extract(epoch from (now() - m.captured_at)) < 600 then 'JUST NOW'
      else 'RECENT'
    end as activity,
    case
      when extract(epoch from (now() - m.captured_at)) >= 120
        then floor(extract(epoch from (now() - m.captured_at)) / 60)::integer || '分前にこの周辺'
      else null
    end as recent_label
  from measured m
  where m.distance_m <= least(greatest(p_radius_m, 1), 10000)
    and m.user_id <> auth.uid()
  order by m.distance_m asc, m.captured_at desc
  limit least(greatest(p_limit, 1), 100);
$$;

revoke all on function public.nearby_users(double precision, double precision, integer, integer) from public, anon, authenticated;
grant execute on function public.nearby_users(double precision, double precision, integer, integer) to authenticated;

commit;
