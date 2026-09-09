-- Generic schema for a client schedule/itinerary site with inline editing.
-- Copy verbatim into the new Supabase project's SQL Editor — no client-specific
-- changes needed here. Run the client's seed INSERTs (see seed-example.sql) right
-- after this in the same SQL Editor session.

create table site_content (
  key text primary key,
  value text not null
);

create table schedule_days (
  id uuid primary key default gen_random_uuid(),
  day_name text not null,
  day_tag text,
  accent text not null default 'rose',
  sort_order int not null
);

create table schedule_entries (
  id uuid primary key default gen_random_uuid(),
  day_id uuid not null references schedule_days(id) on delete cascade,
  time_label text not null,
  title text not null,
  note text,
  photo_url text,
  photo_caption text,
  sort_order int not null
);

create table packing_items (
  id uuid primary key default gen_random_uuid(),
  section text not null,
  text text not null,
  sort_order int not null
);

alter table site_content enable row level security;
alter table schedule_days enable row level security;
alter table schedule_entries enable row level security;
alter table packing_items enable row level security;

create policy "public read site_content" on site_content for select using (true);
create policy "public read schedule_days" on schedule_days for select using (true);
create policy "public read schedule_entries" on schedule_entries for select using (true);
create policy "public read packing_items" on packing_items for select using (true);

-- No write policies — all writes happen server-side through the service-role
-- key (which bypasses RLS entirely), gated by the app's own password-protected
-- cookie, never by Supabase Auth. Don't add write policies here.
