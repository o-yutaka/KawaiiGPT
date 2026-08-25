-- NEAR Wave 2: Realtime publication contract.
-- Raw location_sessions is intentionally NOT added to realtime.

begin;

-- Only social events that are already protected by RLS are published.
alter publication supabase_realtime add table public.messages;
alter publication supabase_realtime add table public.now_posts;

-- Keep replica identity sufficient for realtime UPDATE/DELETE payloads.
alter table public.messages replica identity full;
alter table public.now_posts replica identity full;

commit;
