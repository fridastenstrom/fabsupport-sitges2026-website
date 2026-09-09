-- Seed content for FAB Support · Sitges 8–11 oktober 2026
-- Run this in the Supabase SQL Editor right after schema.sql.

-- 1. site_content: hero + intro + footer copy
insert into site_content (key, value) values
  ('hero_eyebrow', 'Konferensresa'),
  ('hero_title', 'Sitges'),
  ('hero_dates', '8–11 oktober 2026'),
  ('hero_route', ''),
  ('intro_text', ''),
  ('footer_text', 'FAB Support · Sitges · 8–11 oktober 2026');

-- 2. schedule_days
insert into schedule_days (day_name, day_tag, accent, sort_order) values
  ('Torsdag 8 oktober', 'Ankomst', 'violet', 0),
  ('Fredag 9 oktober', null, 'teal', 1),
  ('Lördag 10 oktober', null, 'rose', 2),
  ('Söndag 11 oktober', null, 'violet', 3),
  ('Flyg dit', 'Praktisk information', 'rose', 4),
  ('Flyg hem', null, 'rose', 5),
  ('Bagage', null, 'rose', 6),
  ('Check-in', null, 'rose', 7);

-- 3. schedule_entries

-- Torsdag 8 oktober
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('–', 'Flyg till Barcelona', 'Se flygtider under "Flyg dit" längre ner.', 0),
  ('–', 'Transfer till hotellet', 'Meliá MiM Sitges, cirka 30 minuter från flygplatsen.', 1),
  ('–', 'Egen tid', null, 3)
) as v(time_label, title, note, sort_order)
where day_name = 'Torsdag 8 oktober';

insert into schedule_entries (day_id, time_label, title, note, photo_url, photo_caption, sort_order)
select id, '15.00', 'Incheckning hotell',
  'Meliá MiM Sitges. Utcheckning söndag till 12.00. Bagage kan förvaras både före incheckning och efter utcheckning, och omklädningsrum/dusch finns att använda. Frukost serveras 07.30–11.00.',
  '/hotel.jpg', 'Meliá MiM Sitges', 2
from schedule_days where day_name = 'Torsdag 8 oktober';

insert into schedule_entries (day_id, time_label, title, note, photo_url, photo_caption, sort_order)
select id, '19.00', 'Food Sherpa – mat- och dryckesprovning',
  'Upptäck Sitges genom tre stopp. Mat och dryck ingår. OK Teams hämtar er på hotellet.',
  '/food.jpg', 'Tapas i Sitges', 4
from schedule_days where day_name = 'Torsdag 8 oktober';

-- Fredag 9 oktober
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('07.30', 'Frukost', null, 0),
  ('–', 'Egen tid', null, 2),
  ('19.30', 'Middag på Numeric', 'Inklusive dryckespaket. Gångavstånd från hotellet.', 3)
) as v(time_label, title, note, sort_order)
where day_name = 'Fredag 9 oktober';

insert into schedule_entries (day_id, time_label, title, note, photo_url, photo_caption, sort_order)
select id, '10.00', 'Vandring till Villanova',
  'Lunch i Villanova, buss tillbaka 14.30. OK Teams hämtar er vid hotellet.',
  '/sitges-town.jpg', 'Sitges', 1
from schedule_days where day_name = 'Fredag 9 oktober';

-- Lördag 10 oktober
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('07.30', 'Frukost', null, 0),
  ('15.00', 'Tillbaka på hotellet', null, 2),
  ('–', 'Egen tid', null, 3),
  ('19.30', 'Middag på Vivero Beach Club', 'Inklusive dryckespaket. Gångavstånd från hotellet.', 4)
) as v(time_label, title, note, sort_order)
where day_name = 'Lördag 10 oktober';

insert into schedule_entries (day_id, time_label, title, note, photo_url, photo_caption, sort_order)
select id, '10.00', 'Teamsegling',
  'Med efterföljande lunch 13.30. OK Teams arrangerar och hämtar er vid hotellet.',
  '/sailing.jpg', 'Segling utanför Sitges', 1
from schedule_days where day_name = 'Lördag 10 oktober';

-- Söndag 11 oktober
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('07.30', 'Frukost', null, 0),
  ('–', 'Egen tid', null, 1),
  ('–', 'Hemresa', 'Se flygtider under "Flyg hem" nedan.', 2)
) as v(time_label, title, note, sort_order)
where day_name = 'Söndag 11 oktober';

-- Flyg dit
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('Stockholm', 'SAS, Arlanda', 'SK1811 · Avgång 08.25 → Ankomst 12.00', 0),
  ('Köpenhamn', 'SAS, Kastrup', 'SK1995 · Avgång 08.40 → Ankomst 11.35', 1)
) as v(time_label, title, note, sort_order)
where day_name = 'Flyg dit';

-- Flyg hem
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('Stockholm', 'Ryanair', 'FR3076 · 17.00–20.45', 0),
  ('Stockholm', 'Norwegian', 'D8 4254 · 20.10–23.45', 1),
  ('Köpenhamn', 'SAS', 'SK1586 · 19.00–21.55', 2)
) as v(time_label, title, note, sort_order)
where day_name = 'Flyg hem';

-- Bagage
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('Stockholm', 'SAS dit / Ryanair hem', '1 × 20 kg incheckat + endast liten väska under sätet framför (gäller hela kombinationen)', 0),
  ('Stockholm', 'SAS dit / Norwegian hem', '1 × 23 kg incheckat + 8 kg handbagage', 1),
  ('Köpenhamn', 'SAS tur och retur', '1 × 23 kg incheckat + 8 kg handbagage', 2)
) as v(time_label, title, note, sort_order)
where day_name = 'Bagage';

-- Check-in
insert into schedule_entries (day_id, time_label, title, note, sort_order)
select id, v.time_label, v.title, v.note, v.sort_order
from schedule_days, (values
  ('Alla', 'SAS och Norwegian', 'Öppnar 24 timmar innan avgång, görs online på respektive flygbolags hemsida. Mer info kommer närmare avresa.', 0),
  ('Alla', 'Ryanair', 'I appen: välj Continue as guest, sedan Bookings, sedan Find booking. Logga in med bokning@mkaibroker.se och flygbolagsreferensen för din bokning.', 1)
) as v(time_label, title, note, sort_order)
where day_name = 'Check-in';

-- 4. packing_items
insert into packing_items (section, text, sort_order) values
  ('general', 'Pass / ID', 0),
  ('general', 'Bekväma skor', 1),
  ('general', 'Kläder för varierat väder', 2),
  ('general', 'Laddare / powerbank', 3),
  ('activities', 'Badkläder', 0),
  ('activities', 'Solskydd och solglasögon', 1),
  ('activities', 'Vandringsskor', 2),
  ('activities', 'Lätt jacka för kvällar', 3);

-- Verify after running:
--   select count(*) from schedule_days;     -- should be 8
--   select count(*) from schedule_entries;  -- should be 27
--   select count(*) from packing_items;     -- should be 8
