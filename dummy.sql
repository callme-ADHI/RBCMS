-- =====================================================================
-- RBCMS Dummy Data Script
-- Run in: Supabase Dashboard > SQL Editor
-- Prerequisites: Run admin.sql first so admin accounts exist
--
-- Inserts:
--   40 Students  (password: Student@1234)
--   10 Faculty   (5 approved + 5 pending, password: Faculty@1234)
--   15 Categories
--   15 Category-Faculty assignments
--  100 Complaints (30 pending · 30 processing · 25 done · 15 undone)
--   ~80 Votes
--   ~70 Status-log entries
--   ~90 Notifications
-- =====================================================================

DO $$
DECLARE
  adm  uuid;  -- admin (adhithyakrishna00001@gmail.com)
  s01 uuid := '10000000-0000-0000-0000-000000000001';
  s02 uuid := '10000000-0000-0000-0000-000000000002';
  s03 uuid := '10000000-0000-0000-0000-000000000003';
  s04 uuid := '10000000-0000-0000-0000-000000000004';
  s05 uuid := '10000000-0000-0000-0000-000000000005';
  s06 uuid := '10000000-0000-0000-0000-000000000006';
  s07 uuid := '10000000-0000-0000-0000-000000000007';
  s08 uuid := '10000000-0000-0000-0000-000000000008';
  s09 uuid := '10000000-0000-0000-0000-000000000009';
  s10 uuid := '10000000-0000-0000-0000-000000000010';
  s11 uuid := '10000000-0000-0000-0000-000000000011';
  s12 uuid := '10000000-0000-0000-0000-000000000012';
  s13 uuid := '10000000-0000-0000-0000-000000000013';
  s14 uuid := '10000000-0000-0000-0000-000000000014';
  s15 uuid := '10000000-0000-0000-0000-000000000015';
  s16 uuid := '10000000-0000-0000-0000-000000000016';
  s17 uuid := '10000000-0000-0000-0000-000000000017';
  s18 uuid := '10000000-0000-0000-0000-000000000018';
  s19 uuid := '10000000-0000-0000-0000-000000000019';
  s20 uuid := '10000000-0000-0000-0000-000000000020';
  s21 uuid := '10000000-0000-0000-0000-000000000021';
  s22 uuid := '10000000-0000-0000-0000-000000000022';
  s23 uuid := '10000000-0000-0000-0000-000000000023';
  s24 uuid := '10000000-0000-0000-0000-000000000024';
  s25 uuid := '10000000-0000-0000-0000-000000000025';
  s26 uuid := '10000000-0000-0000-0000-000000000026';
  s27 uuid := '10000000-0000-0000-0000-000000000027';
  s28 uuid := '10000000-0000-0000-0000-000000000028';
  s29 uuid := '10000000-0000-0000-0000-000000000029';
  s30 uuid := '10000000-0000-0000-0000-000000000030';
  s31 uuid := '10000000-0000-0000-0000-000000000031';
  s32 uuid := '10000000-0000-0000-0000-000000000032';
  s33 uuid := '10000000-0000-0000-0000-000000000033';
  s34 uuid := '10000000-0000-0000-0000-000000000034';
  s35 uuid := '10000000-0000-0000-0000-000000000035';
  s36 uuid := '10000000-0000-0000-0000-000000000036';
  s37 uuid := '10000000-0000-0000-0000-000000000037';
  s38 uuid := '10000000-0000-0000-0000-000000000038';
  s39 uuid := '10000000-0000-0000-0000-000000000039';
  s40 uuid := '10000000-0000-0000-0000-000000000040';
  f01 uuid := '20000000-0000-0000-0000-000000000001';
  f02 uuid := '20000000-0000-0000-0000-000000000002';
  f03 uuid := '20000000-0000-0000-0000-000000000003';
  f04 uuid := '20000000-0000-0000-0000-000000000004';
  f05 uuid := '20000000-0000-0000-0000-000000000005';
  f06 uuid := '20000000-0000-0000-0000-000000000006';
  f07 uuid := '20000000-0000-0000-0000-000000000007';
  f08 uuid := '20000000-0000-0000-0000-000000000008';
  f09 uuid := '20000000-0000-0000-0000-000000000009';
  f10 uuid := '20000000-0000-0000-0000-000000000010';
  cat01 uuid := '30000000-0000-0000-0000-000000000001';
  cat02 uuid := '30000000-0000-0000-0000-000000000002';
  cat03 uuid := '30000000-0000-0000-0000-000000000003';
  cat04 uuid := '30000000-0000-0000-0000-000000000004';
  cat05 uuid := '30000000-0000-0000-0000-000000000005';
  cat06 uuid := '30000000-0000-0000-0000-000000000006';
  cat07 uuid := '30000000-0000-0000-0000-000000000007';
  cat08 uuid := '30000000-0000-0000-0000-000000000008';
  cat09 uuid := '30000000-0000-0000-0000-000000000009';
  cat10 uuid := '30000000-0000-0000-0000-000000000010';
  cat11 uuid := '30000000-0000-0000-0000-000000000011';
  cat12 uuid := '30000000-0000-0000-0000-000000000012';
  cat13 uuid := '30000000-0000-0000-0000-000000000013';
  cat14 uuid := '30000000-0000-0000-0000-000000000014';
  cat15 uuid := '30000000-0000-0000-0000-000000000015';
BEGIN
  SELECT id INTO adm FROM auth.users WHERE email = 'adhithyakrishna00001@gmail.com';
  -- Note: the handle_new_user trigger will auto-create profiles on INSERT.
  -- Our ON CONFLICT DO UPDATE below will overwrite with correct data.

  -- ================================================================
  -- STUDENTS: auth.users
  -- ================================================================
  INSERT INTO auth.users (id,instance_id,email,encrypted_password,email_confirmed_at,created_at,updated_at,raw_app_meta_data,raw_user_meta_data,is_super_admin,role,aud) VALUES
    (s01,'00000000-0000-0000-0000-000000000000','24cy101@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:00:00+00','2024-06-10 08:00:00+00','2024-06-10 08:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Aarav Sharma","role":"student"}',false,'authenticated','authenticated'),
    (s02,'00000000-0000-0000-0000-000000000000','24cy102@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:05:00+00','2024-06-10 08:05:00+00','2024-06-10 08:05:00+00','{"provider":"email","providers":["email"]}','{"name":"Priya Nair","role":"student"}',false,'authenticated','authenticated'),
    (s03,'00000000-0000-0000-0000-000000000000','24cy103@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:10:00+00','2024-06-10 08:10:00+00','2024-06-10 08:10:00+00','{"provider":"email","providers":["email"]}','{"name":"Rohit Verma","role":"student"}',false,'authenticated','authenticated'),
    (s04,'00000000-0000-0000-0000-000000000000','24cy104@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:15:00+00','2024-06-10 08:15:00+00','2024-06-10 08:15:00+00','{"provider":"email","providers":["email"]}','{"name":"Sneha Pillai","role":"student"}',false,'authenticated','authenticated'),
    (s05,'00000000-0000-0000-0000-000000000000','24cy105@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:20:00+00','2024-06-10 08:20:00+00','2024-06-10 08:20:00+00','{"provider":"email","providers":["email"]}','{"name":"Arjun Menon","role":"student"}',false,'authenticated','authenticated'),
    (s06,'00000000-0000-0000-0000-000000000000','24cy106@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:25:00+00','2024-06-10 08:25:00+00','2024-06-10 08:25:00+00','{"provider":"email","providers":["email"]}','{"name":"Kavya Reddy","role":"student"}',false,'authenticated','authenticated'),
    (s07,'00000000-0000-0000-0000-000000000000','24cy107@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:30:00+00','2024-06-10 08:30:00+00','2024-06-10 08:30:00+00','{"provider":"email","providers":["email"]}','{"name":"Vikram Singh","role":"student"}',false,'authenticated','authenticated'),
    (s08,'00000000-0000-0000-0000-000000000000','24cy108@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:35:00+00','2024-06-10 08:35:00+00','2024-06-10 08:35:00+00','{"provider":"email","providers":["email"]}','{"name":"Ananya Kumar","role":"student"}',false,'authenticated','authenticated'),
    (s09,'00000000-0000-0000-0000-000000000000','24cy109@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:40:00+00','2024-06-10 08:40:00+00','2024-06-10 08:40:00+00','{"provider":"email","providers":["email"]}','{"name":"Rahul Krishnan","role":"student"}',false,'authenticated','authenticated'),
    (s10,'00000000-0000-0000-0000-000000000000','24cy110@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:45:00+00','2024-06-10 08:45:00+00','2024-06-10 08:45:00+00','{"provider":"email","providers":["email"]}','{"name":"Meera Iyer","role":"student"}',false,'authenticated','authenticated'),
    (s11,'00000000-0000-0000-0000-000000000000','24cy111@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:50:00+00','2024-06-10 08:50:00+00','2024-06-10 08:50:00+00','{"provider":"email","providers":["email"]}','{"name":"Aditya Patel","role":"student"}',false,'authenticated','authenticated'),
    (s12,'00000000-0000-0000-0000-000000000000','24cy112@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 08:55:00+00','2024-06-10 08:55:00+00','2024-06-10 08:55:00+00','{"provider":"email","providers":["email"]}','{"name":"Divya Nambiar","role":"student"}',false,'authenticated','authenticated'),
    (s13,'00000000-0000-0000-0000-000000000000','24cy113@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:00:00+00','2024-06-10 09:00:00+00','2024-06-10 09:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Siddharth Nair","role":"student"}',false,'authenticated','authenticated'),
    (s14,'00000000-0000-0000-0000-000000000000','24cy114@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:05:00+00','2024-06-10 09:05:00+00','2024-06-10 09:05:00+00','{"provider":"email","providers":["email"]}','{"name":"Pooja Menon","role":"student"}',false,'authenticated','authenticated'),
    (s15,'00000000-0000-0000-0000-000000000000','24cy115@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:10:00+00','2024-06-10 09:10:00+00','2024-06-10 09:10:00+00','{"provider":"email","providers":["email"]}','{"name":"Karthik Sharma","role":"student"}',false,'authenticated','authenticated'),
    (s16,'00000000-0000-0000-0000-000000000000','24cy116@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:15:00+00','2024-06-10 09:15:00+00','2024-06-10 09:15:00+00','{"provider":"email","providers":["email"]}','{"name":"Lakshmi Priya","role":"student"}',false,'authenticated','authenticated'),
    (s17,'00000000-0000-0000-0000-000000000000','24cy117@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:20:00+00','2024-06-10 09:20:00+00','2024-06-10 09:20:00+00','{"provider":"email","providers":["email"]}','{"name":"Nikhil Varma","role":"student"}',false,'authenticated','authenticated'),
    (s18,'00000000-0000-0000-0000-000000000000','24cy118@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:25:00+00','2024-06-10 09:25:00+00','2024-06-10 09:25:00+00','{"provider":"email","providers":["email"]}','{"name":"Shreya Pillai","role":"student"}',false,'authenticated','authenticated'),
    (s19,'00000000-0000-0000-0000-000000000000','24cy119@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:30:00+00','2024-06-10 09:30:00+00','2024-06-10 09:30:00+00','{"provider":"email","providers":["email"]}','{"name":"Deepak Raj","role":"student"}',false,'authenticated','authenticated'),
    (s20,'00000000-0000-0000-0000-000000000000','24cy120@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2024-06-10 09:35:00+00','2024-06-10 09:35:00+00','2024-06-10 09:35:00+00','{"provider":"email","providers":["email"]}','{"name":"Anjali Menon","role":"student"}',false,'authenticated','authenticated'),
    (s21,'00000000-0000-0000-0000-000000000000','23cs201@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 08:00:00+00','2023-06-12 08:00:00+00','2023-06-12 08:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Rajan Mathew","role":"student"}',false,'authenticated','authenticated'),
    (s22,'00000000-0000-0000-0000-000000000000','23cs202@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 08:10:00+00','2023-06-12 08:10:00+00','2023-06-12 08:10:00+00','{"provider":"email","providers":["email"]}','{"name":"Swathi Krishnan","role":"student"}',false,'authenticated','authenticated'),
    (s23,'00000000-0000-0000-0000-000000000000','23cs203@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 08:20:00+00','2023-06-12 08:20:00+00','2023-06-12 08:20:00+00','{"provider":"email","providers":["email"]}','{"name":"Prasad Nair","role":"student"}',false,'authenticated','authenticated'),
    (s24,'00000000-0000-0000-0000-000000000000','23cs204@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 08:30:00+00','2023-06-12 08:30:00+00','2023-06-12 08:30:00+00','{"provider":"email","providers":["email"]}','{"name":"Nitha George","role":"student"}',false,'authenticated','authenticated'),
    (s25,'00000000-0000-0000-0000-000000000000','23cs205@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 08:40:00+00','2023-06-12 08:40:00+00','2023-06-12 08:40:00+00','{"provider":"email","providers":["email"]}','{"name":"Ajith Kumar","role":"student"}',false,'authenticated','authenticated'),
    (s26,'00000000-0000-0000-0000-000000000000','23cs206@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 08:50:00+00','2023-06-12 08:50:00+00','2023-06-12 08:50:00+00','{"provider":"email","providers":["email"]}','{"name":"Reshma Saji","role":"student"}',false,'authenticated','authenticated'),
    (s27,'00000000-0000-0000-0000-000000000000','23cs207@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 09:00:00+00','2023-06-12 09:00:00+00','2023-06-12 09:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Vivek Sharma","role":"student"}',false,'authenticated','authenticated'),
    (s28,'00000000-0000-0000-0000-000000000000','23cs208@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 09:10:00+00','2023-06-12 09:10:00+00','2023-06-12 09:10:00+00','{"provider":"email","providers":["email"]}','{"name":"Gopika Suresh","role":"student"}',false,'authenticated','authenticated'),
    (s29,'00000000-0000-0000-0000-000000000000','23cs209@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 09:20:00+00','2023-06-12 09:20:00+00','2023-06-12 09:20:00+00','{"provider":"email","providers":["email"]}','{"name":"Arun Prakash","role":"student"}',false,'authenticated','authenticated'),
    (s30,'00000000-0000-0000-0000-000000000000','23cs210@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2023-06-12 09:30:00+00','2023-06-12 09:30:00+00','2023-06-12 09:30:00+00','{"provider":"email","providers":["email"]}','{"name":"Saritha Tom","role":"student"}',false,'authenticated','authenticated'),
    (s31,'00000000-0000-0000-0000-000000000000','22ec301@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 08:00:00+00','2022-06-15 08:00:00+00','2022-06-15 08:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Jithin Thomas","role":"student"}',false,'authenticated','authenticated'),
    (s32,'00000000-0000-0000-0000-000000000000','22ec302@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 08:10:00+00','2022-06-15 08:10:00+00','2022-06-15 08:10:00+00','{"provider":"email","providers":["email"]}','{"name":"Asha Balan","role":"student"}',false,'authenticated','authenticated'),
    (s33,'00000000-0000-0000-0000-000000000000','22ec303@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 08:20:00+00','2022-06-15 08:20:00+00','2022-06-15 08:20:00+00','{"provider":"email","providers":["email"]}','{"name":"Midhun Raj","role":"student"}',false,'authenticated','authenticated'),
    (s34,'00000000-0000-0000-0000-000000000000','22ec304@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 08:30:00+00','2022-06-15 08:30:00+00','2022-06-15 08:30:00+00','{"provider":"email","providers":["email"]}','{"name":"Parvathy Nair","role":"student"}',false,'authenticated','authenticated'),
    (s35,'00000000-0000-0000-0000-000000000000','22ec305@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 08:40:00+00','2022-06-15 08:40:00+00','2022-06-15 08:40:00+00','{"provider":"email","providers":["email"]}','{"name":"Sreekanth KV","role":"student"}',false,'authenticated','authenticated'),
    (s36,'00000000-0000-0000-0000-000000000000','22ec306@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 08:50:00+00','2022-06-15 08:50:00+00','2022-06-15 08:50:00+00','{"provider":"email","providers":["email"]}','{"name":"Amritha Sasi","role":"student"}',false,'authenticated','authenticated'),
    (s37,'00000000-0000-0000-0000-000000000000','22ec307@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 09:00:00+00','2022-06-15 09:00:00+00','2022-06-15 09:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Ashwin Menon","role":"student"}',false,'authenticated','authenticated'),
    (s38,'00000000-0000-0000-0000-000000000000','22ec308@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 09:10:00+00','2022-06-15 09:10:00+00','2022-06-15 09:10:00+00','{"provider":"email","providers":["email"]}','{"name":"Deepthi John","role":"student"}',false,'authenticated','authenticated'),
    (s39,'00000000-0000-0000-0000-000000000000','22ec309@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 09:20:00+00','2022-06-15 09:20:00+00','2022-06-15 09:20:00+00','{"provider":"email","providers":["email"]}','{"name":"Naveen Pillai","role":"student"}',false,'authenticated','authenticated'),
    (s40,'00000000-0000-0000-0000-000000000000','22ec310@mgits.ac.in',crypt('Student@1234',gen_salt('bf')),'2022-06-15 09:30:00+00','2022-06-15 09:30:00+00','2022-06-15 09:30:00+00','{"provider":"email","providers":["email"]}','{"name":"Sandra Jose","role":"student"}',false,'authenticated','authenticated')
  ON CONFLICT (email) DO NOTHING;

  -- ================================================================
  -- FACULTY: auth.users
  -- ================================================================
  INSERT INTO auth.users (id,instance_id,email,encrypted_password,email_confirmed_at,created_at,updated_at,raw_app_meta_data,raw_user_meta_data,is_super_admin,role,aud) VALUES
    (f01,'00000000-0000-0000-0000-000000000000','rajesh.kumar@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2021-07-01 09:00:00+00','2021-07-01 09:00:00+00','2021-07-01 09:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Dr. Rajesh Kumar","role":"faculty"}',false,'authenticated','authenticated'),
    (f02,'00000000-0000-0000-0000-000000000000','meena.babu@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2021-07-01 09:10:00+00','2021-07-01 09:10:00+00','2021-07-01 09:10:00+00','{"provider":"email","providers":["email"]}','{"name":"Prof. Meena Babu","role":"faculty"}',false,'authenticated','authenticated'),
    (f03,'00000000-0000-0000-0000-000000000000','suresh.nair@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2021-07-01 09:20:00+00','2021-07-01 09:20:00+00','2021-07-01 09:20:00+00','{"provider":"email","providers":["email"]}','{"name":"Dr. Suresh Nair","role":"faculty"}',false,'authenticated','authenticated'),
    (f04,'00000000-0000-0000-0000-000000000000','latha.krishnan@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2021-07-01 09:30:00+00','2021-07-01 09:30:00+00','2021-07-01 09:30:00+00','{"provider":"email","providers":["email"]}','{"name":"Prof. Latha Krishnan","role":"faculty"}',false,'authenticated','authenticated'),
    (f05,'00000000-0000-0000-0000-000000000000','anil.varghese@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2021-07-01 09:40:00+00','2021-07-01 09:40:00+00','2021-07-01 09:40:00+00','{"provider":"email","providers":["email"]}','{"name":"Dr. Anil Varghese","role":"faculty"}',false,'authenticated','authenticated'),
    (f06,'00000000-0000-0000-0000-000000000000','bindu.thomas@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2026-01-10 10:00:00+00','2026-01-10 10:00:00+00','2026-01-10 10:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Prof. Bindu Thomas","role":"faculty"}',false,'authenticated','authenticated'),
    (f07,'00000000-0000-0000-0000-000000000000','ravi.prakash@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2026-01-12 10:00:00+00','2026-01-12 10:00:00+00','2026-01-12 10:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Dr. Ravi Prakash","role":"faculty"}',false,'authenticated','authenticated'),
    (f08,'00000000-0000-0000-0000-000000000000','seema.nambiar@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2026-01-15 10:00:00+00','2026-01-15 10:00:00+00','2026-01-15 10:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Prof. Seema Nambiar","role":"faculty"}',false,'authenticated','authenticated'),
    (f09,'00000000-0000-0000-0000-000000000000','jijo.abraham@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2026-02-01 10:00:00+00','2026-02-01 10:00:00+00','2026-02-01 10:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Dr. Jijo Abraham","role":"faculty"}',false,'authenticated','authenticated'),
    (f10,'00000000-0000-0000-0000-000000000000','anju.sreedharan@mgits.ac.in',crypt('Faculty@1234',gen_salt('bf')),'2026-02-05 10:00:00+00','2026-02-05 10:00:00+00','2026-02-05 10:00:00+00','{"provider":"email","providers":["email"]}','{"name":"Prof. Anju Sreedharan","role":"faculty"}',false,'authenticated','authenticated')
  ON CONFLICT (email) DO NOTHING;

  -- ================================================================
  -- STUDENT profiles  (ON CONFLICT updates what the trigger created)
  -- ================================================================
  INSERT INTO public.profiles (id,name,email,role,approval_status,created_at) VALUES
    (s01,'Aarav Sharma','24cy101@mgits.ac.in','student','approved','2024-06-10 08:00:00+00'),
    (s02,'Priya Nair','24cy102@mgits.ac.in','student','approved','2024-06-10 08:05:00+00'),
    (s03,'Rohit Verma','24cy103@mgits.ac.in','student','approved','2024-06-10 08:10:00+00'),
    (s04,'Sneha Pillai','24cy104@mgits.ac.in','student','approved','2024-06-10 08:15:00+00'),
    (s05,'Arjun Menon','24cy105@mgits.ac.in','student','approved','2024-06-10 08:20:00+00'),
    (s06,'Kavya Reddy','24cy106@mgits.ac.in','student','approved','2024-06-10 08:25:00+00'),
    (s07,'Vikram Singh','24cy107@mgits.ac.in','student','approved','2024-06-10 08:30:00+00'),
    (s08,'Ananya Kumar','24cy108@mgits.ac.in','student','approved','2024-06-10 08:35:00+00'),
    (s09,'Rahul Krishnan','24cy109@mgits.ac.in','student','approved','2024-06-10 08:40:00+00'),
    (s10,'Meera Iyer','24cy110@mgits.ac.in','student','approved','2024-06-10 08:45:00+00'),
    (s11,'Aditya Patel','24cy111@mgits.ac.in','student','approved','2024-06-10 08:50:00+00'),
    (s12,'Divya Nambiar','24cy112@mgits.ac.in','student','approved','2024-06-10 08:55:00+00'),
    (s13,'Siddharth Nair','24cy113@mgits.ac.in','student','approved','2024-06-10 09:00:00+00'),
    (s14,'Pooja Menon','24cy114@mgits.ac.in','student','approved','2024-06-10 09:05:00+00'),
    (s15,'Karthik Sharma','24cy115@mgits.ac.in','student','approved','2024-06-10 09:10:00+00'),
    (s16,'Lakshmi Priya','24cy116@mgits.ac.in','student','approved','2024-06-10 09:15:00+00'),
    (s17,'Nikhil Varma','24cy117@mgits.ac.in','student','approved','2024-06-10 09:20:00+00'),
    (s18,'Shreya Pillai','24cy118@mgits.ac.in','student','approved','2024-06-10 09:25:00+00'),
    (s19,'Deepak Raj','24cy119@mgits.ac.in','student','approved','2024-06-10 09:30:00+00'),
    (s20,'Anjali Menon','24cy120@mgits.ac.in','student','approved','2024-06-10 09:35:00+00'),
    (s21,'Rajan Mathew','23cs201@mgits.ac.in','student','approved','2023-06-12 08:00:00+00'),
    (s22,'Swathi Krishnan','23cs202@mgits.ac.in','student','approved','2023-06-12 08:10:00+00'),
    (s23,'Prasad Nair','23cs203@mgits.ac.in','student','approved','2023-06-12 08:20:00+00'),
    (s24,'Nitha George','23cs204@mgits.ac.in','student','approved','2023-06-12 08:30:00+00'),
    (s25,'Ajith Kumar','23cs205@mgits.ac.in','student','approved','2023-06-12 08:40:00+00'),
    (s26,'Reshma Saji','23cs206@mgits.ac.in','student','approved','2023-06-12 08:50:00+00'),
    (s27,'Vivek Sharma','23cs207@mgits.ac.in','student','approved','2023-06-12 09:00:00+00'),
    (s28,'Gopika Suresh','23cs208@mgits.ac.in','student','approved','2023-06-12 09:10:00+00'),
    (s29,'Arun Prakash','23cs209@mgits.ac.in','student','approved','2023-06-12 09:20:00+00'),
    (s30,'Saritha Tom','23cs210@mgits.ac.in','student','approved','2023-06-12 09:30:00+00'),
    (s31,'Jithin Thomas','22ec301@mgits.ac.in','student','approved','2022-06-15 08:00:00+00'),
    (s32,'Asha Balan','22ec302@mgits.ac.in','student','approved','2022-06-15 08:10:00+00'),
    (s33,'Midhun Raj','22ec303@mgits.ac.in','student','approved','2022-06-15 08:20:00+00'),
    (s34,'Parvathy Nair','22ec304@mgits.ac.in','student','approved','2022-06-15 08:30:00+00'),
    (s35,'Sreekanth KV','22ec305@mgits.ac.in','student','approved','2022-06-15 08:40:00+00'),
    (s36,'Amritha Sasi','22ec306@mgits.ac.in','student','approved','2022-06-15 08:50:00+00'),
    (s37,'Ashwin Menon','22ec307@mgits.ac.in','student','approved','2022-06-15 09:00:00+00'),
    (s38,'Deepthi John','22ec308@mgits.ac.in','student','approved','2022-06-15 09:10:00+00'),
    (s39,'Naveen Pillai','22ec309@mgits.ac.in','student','approved','2022-06-15 09:20:00+00'),
    (s40,'Sandra Jose','22ec310@mgits.ac.in','student','approved','2022-06-15 09:30:00+00')
  ON CONFLICT (id) DO UPDATE SET name=EXCLUDED.name,email=EXCLUDED.email,role=EXCLUDED.role,approval_status=EXCLUDED.approval_status;

  -- ================================================================
  -- FACULTY profiles
  -- ================================================================
  INSERT INTO public.profiles (id,name,email,role,approval_status,created_at) VALUES
    (f01,'Dr. Rajesh Kumar','rajesh.kumar@mgits.ac.in','faculty','approved','2021-07-01 09:00:00+00'),
    (f02,'Prof. Meena Babu','meena.babu@mgits.ac.in','faculty','approved','2021-07-01 09:10:00+00'),
    (f03,'Dr. Suresh Nair','suresh.nair@mgits.ac.in','faculty','approved','2021-07-01 09:20:00+00'),
    (f04,'Prof. Latha Krishnan','latha.krishnan@mgits.ac.in','faculty','approved','2021-07-01 09:30:00+00'),
    (f05,'Dr. Anil Varghese','anil.varghese@mgits.ac.in','faculty','approved','2021-07-01 09:40:00+00'),
    (f06,'Prof. Bindu Thomas','bindu.thomas@mgits.ac.in','faculty','pending','2026-01-10 10:00:00+00'),
    (f07,'Dr. Ravi Prakash','ravi.prakash@mgits.ac.in','faculty','pending','2026-01-12 10:00:00+00'),
    (f08,'Prof. Seema Nambiar','seema.nambiar@mgits.ac.in','faculty','pending','2026-01-15 10:00:00+00'),
    (f09,'Dr. Jijo Abraham','jijo.abraham@mgits.ac.in','faculty','pending','2026-02-01 10:00:00+00'),
    (f10,'Prof. Anju Sreedharan','anju.sreedharan@mgits.ac.in','faculty','pending','2026-02-05 10:00:00+00')
  ON CONFLICT (id) DO UPDATE SET name=EXCLUDED.name,email=EXCLUDED.email,role=EXCLUDED.role,approval_status=EXCLUDED.approval_status;

  -- ================================================================
  -- CATEGORIES (15)
  -- ================================================================
  INSERT INTO public.categories (id,name,description,created_by,created_at) VALUES
    (cat01,'Infrastructure & Campus Maintenance','Building upkeep, electrical, plumbing, civil works on campus',adm,'2024-08-01 09:00:00+00'),
    (cat02,'Hostel & Accommodation','Hostel facilities, rooms, common areas, warden issues',adm,'2024-08-01 09:00:00+00'),
    (cat03,'Library & Study Resources','Books, journals, reading rooms, library systems',adm,'2024-08-01 09:00:00+00'),
    (cat04,'Laboratory & Equipment','Lab equipment, software, hardware, maintenance',adm,'2024-08-01 10:00:00+00'),
    (cat05,'Teaching & Academic Quality','Lecture quality, syllabus coverage, faculty attendance',adm,'2024-08-01 10:00:00+00'),
    (cat06,'Examination & Assessment','Exam schedules, answer scripts, evaluation fairness',adm,'2024-08-01 10:00:00+00'),
    (cat07,'Food & Canteen Services','Food quality, pricing, hygiene, canteen timings',adm,'2024-08-01 10:00:00+00'),
    (cat08,'Transportation & Bus Services','College buses, routes, timing, driver behaviour',adm,'2024-08-01 11:00:00+00'),
    (cat09,'Internet & IT Infrastructure','WiFi, LAN, college systems, portals, website',adm,'2024-08-01 11:00:00+00'),
    (cat10,'Sports & Extracurricular Activities','Sports facilities, events, clubs, cultural activities',adm,'2024-08-01 11:00:00+00'),
    (cat11,'Health & Medical Services','Medical room, first aid, ambulance, health camps',adm,'2024-08-01 11:00:00+00'),
    (cat12,'Scholarship & Financial Aid','Scholarships, fee concession, financial assistance',adm,'2024-08-01 12:00:00+00'),
    (cat13,'Administrative & Office Services','Certificates, bonafide, TC, office response time',adm,'2024-08-01 12:00:00+00'),
    (cat14,'Cleanliness & Hygiene','Washrooms, campus cleanliness, waste management',adm,'2024-08-01 12:00:00+00'),
    (cat15,'Security & Safety','Campus security, CCTV, entry/exit monitoring',adm,'2024-08-01 12:00:00+00')
  ON CONFLICT (id) DO NOTHING;

  -- ================================================================
  -- CATEGORY-FACULTY assignments
  -- ================================================================
  INSERT INTO public.category_faculty (id,category_id,faculty_id) VALUES
    (gen_random_uuid(),cat01,f01),
    (gen_random_uuid(),cat02,f02),
    (gen_random_uuid(),cat03,f03),
    (gen_random_uuid(),cat04,f01),
    (gen_random_uuid(),cat05,f04),
    (gen_random_uuid(),cat06,f04),
    (gen_random_uuid(),cat07,f02),
    (gen_random_uuid(),cat08,f05),
    (gen_random_uuid(),cat09,f03),
    (gen_random_uuid(),cat10,f05),
    (gen_random_uuid(),cat11,f02),
    (gen_random_uuid(),cat12,f04),
    (gen_random_uuid(),cat13,f01),
    (gen_random_uuid(),cat14,f05),
    (gen_random_uuid(),cat15,f03),
    (gen_random_uuid(),cat01,f05),
    (gen_random_uuid(),cat03,f04),
    (gen_random_uuid(),cat09,f01)
  ON CONFLICT (category_id,faculty_id) DO NOTHING;

  -- ================================================================
  -- COMPLAINTS (100)
  -- ================================================================
  INSERT INTO public.complaints (id,user_id,category_id,title,description,visibility,status,assigned_to,created_at) VALUES
    ('40000000-0000-0000-0000-000000000001',s01,cat01,'Ceiling fan not working in Block A Room 204','Fan has been faulty for two weeks. Room is unbearably hot during afternoons.','public','pending',f01,'2026-01-05 10:30:00+00'),
    ('40000000-0000-0000-0000-000000000002',s02,cat01,'Water leakage from roof in Seminar Hall','Rainwater drips onto front rows during classes. Damage is worsening.','public','pending',f01,'2026-01-07 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000003',s03,cat14,'Washrooms in Block B not cleaned during afternoon','Washrooms are left unclean from lunch break until evening.','public','pending',f05,'2026-01-08 09:15:00+00'),
    ('40000000-0000-0000-0000-000000000004',s04,cat09,'WiFi dead in Block A and B for three days','Both student and staff networks offline. Assignments cannot be submitted.','public','pending',f03,'2026-01-09 14:00:00+00'),
    ('40000000-0000-0000-0000-000000000005',s05,cat07,'Cockroach found in food served at canteen','A live cockroach was found in rice served at the main counter on 8 Jan.','public','pending',f02,'2026-01-10 12:30:00+00'),
    ('40000000-0000-0000-0000-000000000006',s06,cat08,'Route 3 bus arrives 35 minutes late daily','Bus arrives at 8:35 AM instead of 8:00 AM causing students to miss first hour.','public','pending',f05,'2026-01-11 08:45:00+00'),
    ('40000000-0000-0000-0000-000000000007',s07,cat03,'Data Structures textbook unavailable — only 2 copies','CS301 reference book has only 2 copies for 120 students. Please add stock.','public','pending',f03,'2026-01-12 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000008',s08,cat04,'CRO in Electronics Lab 1 shows incorrect readings','Three cathode-ray oscilloscopes give wrong readings. Lab work is affected.','public','pending',f01,'2026-01-13 11:30:00+00'),
    ('40000000-0000-0000-0000-000000000009',s09,cat05,'Professor regularly 20 minutes late to CS8301','Lecturer has been late to every class this semester with no explanation.','private','pending',f04,'2026-01-14 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000010',s10,cat06,'Supplementary exam schedule not yet announced','Students due for supplementary exams are anxious with no schedule released.','public','pending',f04,'2026-01-15 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000011',s11,cat02,'No hot water in Boys Hostel Block C since last Monday','Geyser broken for 10 days. Cold showers in January are health hazard.','public','pending',f02,'2026-01-16 07:00:00+00'),
    ('40000000-0000-0000-0000-000000000012',s12,cat11,'Medical room unstaffed during afternoon hours','Nurse absent after 1 PM daily. Two students had to self-treat minor injuries.','public','pending',f02,'2026-01-17 14:30:00+00'),
    ('40000000-0000-0000-0000-000000000013',s13,cat12,'Merit scholarship payment delayed by 4 months','Scholarship credited to portal but funds not disbursed to accounts yet.','public','pending',f04,'2026-01-18 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000014',s14,cat13,'Bonafide certificate issuance taking over 2 weeks','Applied on Jan 3, still not received. Required urgently for bank loan process.','private','pending',f01,'2026-01-19 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000015',s15,cat15,'Unknown persons entering campus without ID verification','Security guard absent at main gate; outsiders enter freely.','public','pending',f03,'2026-01-20 16:00:00+00'),
    ('40000000-0000-0000-0000-000000000016',s16,cat10,'Basketball court net completely torn','Net has been torn for a month. Court is unusable for practice or matches.','public','pending',f05,'2026-01-21 15:00:00+00'),
    ('40000000-0000-0000-0000-000000000017',s17,cat01,'Broken bench in Classroom C201','Three benches broken. Students sit on floor during back-to-back lectures.','public','pending',f01,'2026-01-22 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000018',s18,cat09,'Online assignment portal throws 500 errors on submission','Students unable to submit CS8302 assignment. Deadline tomorrow.','public','pending',f03,'2026-01-23 20:00:00+00'),
    ('40000000-0000-0000-0000-000000000019',s19,cat07,'Canteen meal price increased 30% without prior notice','Prices hiked from Rs 40 to Rs 52 per meal without announcement.','public','pending',f02,'2026-01-24 13:00:00+00'),
    ('40000000-0000-0000-0000-000000000020',s20,cat02,'Hostel room door lock broken in Room H-214','Lock broken for 5 days. Room insecurity is a serious concern for occupants.','private','pending',f02,'2026-01-25 18:00:00+00'),
    ('40000000-0000-0000-0000-000000000021',s21,cat04,'MATLAB licence expired on all CAD Lab computers','Licence expired 3 weeks ago. Final year projects blocked without access.','public','pending',f01,'2026-02-01 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000022',s22,cat03,'Library AC not functioning for 3 weeks','Reading area temperature exceeds 34°C. Students unable to study inside.','public','pending',f03,'2026-02-02 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000023',s23,cat15,'CCTV camera at Block A entrance not working','Camera offline for two weeks. Theft incidents reported in Block A.','public','pending',f03,'2026-02-03 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000024',s24,cat14,'Garbage bins overflowing near canteen for 4 days','Bins not cleared over weekend. Stench and hygiene concern for eating area.','public','pending',f05,'2026-02-04 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000025',s25,cat08,'No bus service on Saturdays discontinued without notice','Saturday bus cancelled from Feb. Students with Saturday classes have no option.','public','pending',f05,'2026-02-05 07:30:00+00'),
    ('40000000-0000-0000-0000-000000000026',s26,cat06,'Answer scripts from November exam not returned','Scripts from Nov internal exam not returned. Semester end-exam is next week.','public','pending',f04,'2026-02-06 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000027',s27,cat05,'Syllabus coverage incomplete — 3 units not taught','Faculty left 3 units uncovered with 2 weeks to end-semester exam.','private','pending',f04,'2026-02-07 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000028',s28,cat11,'First aid kit missing from Computer Lab 2','First aid kit is empty. Minor injuries cannot be treated immediately.','public','pending',f02,'2026-02-08 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000029',s29,cat12,'Fee concession form link gives 404 on college website','Cannot apply for fee concession. Link broken. Finance office unhelpful.','public','pending',f04,'2026-02-09 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000030',s30,cat13,'TC issuance taking more than 3 weeks','Applied on Jan 15. TC needed urgently for admission elsewhere. No updates given.','private','pending',f01,'2026-02-10 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000031',s01,cat01,'Paint peeling on Block A 3rd floor corridor walls','Paint falling in chunks poses a safety risk for students and staff walking by.','public','processing',f01,'2025-12-10 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000032',s02,cat02,'Hostel common room TV not functioning for 2 weeks','Common room TV broken. Students have no recreational facility in evenings.','public','processing',f02,'2025-12-11 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000033',s03,cat03,'Online journal access broken on library terminals','E-journal website no longer opens on library computers. Password error shown.','public','processing',f03,'2025-12-12 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000034',s04,cat04,'Python 3 not installed on Lab 3 PCs','All 30 computers missing Python. Web dev lab sessions cannot proceed.','public','processing',f01,'2025-12-13 09:30:00+00'),
    ('40000000-0000-0000-0000-000000000035',s05,cat05,'No substitute assigned for Prof. on medical leave','CS8305 has had no classes for 3 weeks. Substitution promised but not delivered.','public','processing',f04,'2025-12-14 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000036',s06,cat06,'Internal assessment marks not published after 4 weeks','Internal marks for Nov exam still missing on student portal.','public','processing',f04,'2025-12-15 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000037',s07,cat07,'Drinking water cooler on 2nd floor not working','Water cooler broken for 10 days. Students forced to bring water from home.','public','processing',f02,'2025-12-16 08:30:00+00'),
    ('40000000-0000-0000-0000-000000000038',s08,cat08,'Bus driver overspeeding on highway stretch daily','Driver consistently overspeeds between Perumbavoor and campus. Dangerous.','public','processing',f05,'2025-12-17 07:00:00+00'),
    ('40000000-0000-0000-0000-000000000039',s09,cat09,'College website down every Monday morning','Website unavailable every Monday 8–10 AM. Timetable and notices inaccessible.','public','processing',f03,'2025-12-18 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000040',s10,cat10,'Cricket pitch not maintained — full of weeds and stones','Pitch abandoned. Regular inter-department match cannot be played safely.','public','processing',f05,'2025-12-19 15:00:00+00'),
    ('40000000-0000-0000-0000-000000000041',s11,cat11,'Ambulance not available during weekend hours','No ambulance on campus Saturday afternoon. Emergency student had to use auto.','public','processing',f02,'2025-12-20 14:00:00+00'),
    ('40000000-0000-0000-0000-000000000042',s12,cat12,'National scholarship portal OTP not delivered','College email server not forwarding OTPs. Students missing scholarship deadline.','public','processing',f04,'2025-12-21 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000043',s13,cat13,'Duplicate marksheet request pending for 5 weeks','Original lost; duplicate requested 5 weeks ago. Exam section gives no update.','private','processing',f01,'2025-12-22 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000044',s14,cat14,'Girls washroom door lock broken on Block C 1st floor','Broken bolt on main stall. Female students have raised the concern 3 times.','private','processing',f05,'2025-12-23 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000045',s15,cat15,'Visitor register not maintained at security cabin','Gate security not logging visitor entry/exit. Multiple unrecognised persons seen.','public','processing',f03,'2025-12-24 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000046',s16,cat01,'Electrical short circuit in Block B corridor tripped MCB','Third short circuit this month. Lights in B-wing fail every week.','public','processing',f01,'2025-12-26 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000047',s17,cat02,'Mosquito nets not provided in hostel rooms','Dengue season and not a single room has a net. Health department visit pending.','public','processing',f02,'2025-12-27 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000048',s18,cat03,'Study hall chairs broken and unstable','About 20 chairs wobble or have broken back-supports. Injury risk for students.','public','processing',f03,'2025-12-28 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000049',s19,cat04,'Printer in Computer Lab 2 out of service since Dec','Printer broken. Students printing assignments paying at shop 2 km away.','public','processing',f01,'2025-12-29 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000050',s20,cat05,'CS8301 course material not distributed','Lecture slides and notes not shared for 4-credit core module.','public','processing',f04,'2025-12-30 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000051',s21,cat06,'Exam hall seating uncomfortably cramped','Desks only 30 cm apart in Hall 3. Candidates complain of shoulder collisions.','public','processing',f04,'2026-01-02 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000052',s22,cat07,'No vegetarian option at canteen after 1 PM','Only non-veg available post 1 PM. Vegetarian students go hungry.','public','processing',f02,'2026-01-03 13:00:00+00'),
    ('40000000-0000-0000-0000-000000000053',s23,cat08,'Bus overcrowded — students standing dangerously','Route 2 bus carries 80+ students with seating for 50. Safety concern.','public','processing',f05,'2026-01-04 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000054',s24,cat09,'LAN cables in Block D classroom damaged','Network cables pulled out or cut. Wired internet unavailable in D-wing.','public','processing',f03,'2026-01-05 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000055',s25,cat10,'Badminton court flood light fused — unusable at night','Students cannot use court after 6 PM. Requested bulb change 3 weeks ago.','public','processing',f05,'2026-01-06 17:00:00+00'),
    ('40000000-0000-0000-0000-000000000056',s26,cat11,'Eye-wash station in Chemistry Lab not functional','Tap corroded and stuck. Safety equipment non-functional before lab sessions.','public','processing',f02,'2026-01-07 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000057',s27,cat12,'SC/ST scholarship form not available at admin office','Office says form is online but link leads to old portal that is decommissioned.','public','processing',f04,'2026-01-08 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000058',s28,cat13,'Migration certificate delayed — admission deadline near','Migration cert applied Jan 1. PG college admission closes Jan 31.','private','processing',f01,'2026-01-09 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000059',s29,cat14,'Dustbins absent from all classroom corridors in Block C','No waste bins on any floor of Block C. Students littering due to no bins.','public','processing',f05,'2026-01-10 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000060',s30,cat15,'Bike parking area has no security at night','Two bikes stolen last month from unguarded parking area near Block D.','public','processing',f03,'2026-01-11 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000061',s31,cat01,'Main entrance gate floodlight repaired','Entrance was dark for a week. Lamp replaced and tested.','public','done',f01,'2025-10-05 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000062',s32,cat02,'Hot water restored in Girls Hostel Block A','Geyser repaired after complaint. Hot water available from 6 AM.','public','done',f02,'2025-10-07 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000063',s33,cat03,'New copies of DBMS textbook procured','Library added 10 new copies of Ramakrishnan DBMS. Accessible to all students.','public','done',f03,'2025-10-10 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000064',s34,cat04,'Oscilloscope in ECE Lab 2 calibrated and repaired','All 6 CROs calibrated. Lab sessions resumed normally.','public','done',f01,'2025-10-12 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000065',s35,cat05,'Substitute assigned for absent Maths professor','HOD arranged substitute within 3 days. Classes are now regular.','public','done',f04,'2025-10-14 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000066',s36,cat06,'Internal marks published on student portal','All Nov internal marks updated. Students can view semester standing.','public','done',f04,'2025-10-16 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000067',s37,cat07,'Canteen hygiene improved after inspection','Health inspector visited. Kitchen and serving area deep cleaned. Passes test.','public','done',f02,'2025-10-18 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000068',s38,cat08,'Route 1 bus timing corrected to 7:55 AM','College coordinatied with bus company. Bus now punctual.','public','done',f05,'2025-10-20 07:30:00+00'),
    ('40000000-0000-0000-0000-000000000069',s39,cat09,'WiFi access points replaced in Block C','New access points installed. Coverage and speed improved significantly.','public','done',f03,'2025-10-22 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000070',s40,cat10,'Football goal posts repainted and nets replaced','Goal posts fixed, new nets fitted. Ground ready for intramural tournament.','public','done',f05,'2025-10-24 15:00:00+00'),
    ('40000000-0000-0000-0000-000000000071',s01,cat11,'Medical room staffed on all working days now','Nurse attendance extended to 4 PM after complaint escalation to principal.','public','done',f02,'2025-10-26 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000072',s02,cat12,'Scholarship disbursement completed for all eligible','Funds credited to 87 eligible student accounts after one-month delay.','public','done',f04,'2025-10-28 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000073',s03,cat13,'Bonafide certificate same-day issuance reinstated','Admin office now issues bonafide within 2 hours of application.','public','done',f01,'2025-10-30 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000074',s04,cat14,'Washrooms in Block A deep-cleaned and restocked','New cleaning roster implemented. Checked every 2 hours.','public','done',f05,'2025-11-01 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000075',s05,cat15,'CCTV system overhauled — 12 new cameras installed','New cameras cover all entry/exit points, corridors, and parking areas.','public','done',f03,'2025-11-03 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000076',s06,cat01,'Roof leakage in Block A sealed before monsoon','Waterproofing done on the terrace. Seepages repaired. Seminar Hall is dry now.','public','done',f01,'2025-11-05 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000077',s07,cat02,'Hostel room locks replaced in Block D','40 room locks replaced. Master key system upgraded.','public','done',f02,'2025-11-07 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000078',s08,cat04,'Software tools updated across all CS labs','All 120 lab PCs updated: Python 3.12, VS Code, Node.js, and MySQL installed.','public','done',f01,'2025-11-09 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000079',s09,cat07,'New canteen vendor appointed after quality complaints','Canteen management changed. New vendor serves improved meals from Jan.','public','done',f02,'2025-11-10 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000080',s10,cat08,'Additional bus added on Route 3 morning slot','Second bus deployed from Jan. Overcrowding issue resolved.','public','done',f05,'2025-11-12 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000081',s11,cat09,'Student portal upgraded — submissions working','New server deployed. Assignment and result portal speed improved.','public','done',f03,'2025-11-14 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000082',s12,cat03,'Quiet study zone created in library first floor','First floor designated silent study zone. New furniture provided.','public','done',f03,'2025-11-16 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000083',s13,cat10,'Volleyball court net and poles replaced','New net and steel poles installed. Court ready for use.','public','done',f05,'2025-11-18 15:00:00+00'),
    ('40000000-0000-0000-0000-000000000084',s14,cat11,'First aid kits restocked in all labs','21 labs restocked with certified first aid kits. Checked monthly.','public','done',f02,'2025-11-20 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000085',s15,cat13,'TC issuance turnaround reduced to 5 working days','New SOP implemented. TC now processed in 5 days with principal''s e-signature.','public','done',f01,'2025-11-22 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000086',s16,cat01,'Request to install AC in Block A classrooms','Classrooms need AC for summer. Management decided within existing budget no AC.','public','undone',f01,'2025-09-05 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000087',s17,cat02,'Request for individual study tables in hostel rooms','Each student wants a dedicated desk. Hostel warden says space insufficient.','public','undone',f02,'2025-09-07 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000088',s18,cat03,'Request to extend library hours to midnight','Night owl students want 24/7 library. Security and staffing costs prohibit it.','public','undone',f03,'2025-09-09 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000089',s19,cat05,'Request to record and upload all lectures','Students want recorded lectures. Faculty union opposed. Request declined.','public','undone',f04,'2025-09-10 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000090',s20,cat08,'Request for college bus from Edappally junction','Route too far from current terminal. Bus company declined additional stop.','public','undone',f05,'2025-09-11 07:30:00+00'),
    ('40000000-0000-0000-0000-000000000091',s21,cat07,'Request for subsidised dinner at canteen after 7 PM','Evening meal subsidy not feasible per current finance allocation.','public','undone',f02,'2025-09-12 18:00:00+00'),
    ('40000000-0000-0000-0000-000000000092',s22,cat10,'Request to build a swimming pool on campus','Infrastructure cost exceeds annual capital budget. Deferred indefinitely.','public','undone',f05,'2025-09-13 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000093',s23,cat09,'Request for 100 Mbps dedicated WiFi in hostel','ISP bandwidth upgrade cost too high. Current 50 Mbps retained for now.','public','undone',f03,'2025-09-14 11:00:00+00'),
    ('40000000-0000-0000-0000-000000000094',s24,cat12,'Request to waive exam fee for all re-appearance students','Fee waiver not permissible under university regulations. Request closed.','public','undone',f04,'2025-09-15 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000095',s25,cat06,'Request to shift end-semester exam dates by 2 weeks','University controls exam schedule. College cannot alter dates unilaterally.','public','undone',f04,'2025-09-16 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000096',s26,cat14,'Request for scented disinfectant in washrooms','Procurement committee chose standard disinfectant. Scented not in contract.','public','undone',f05,'2025-09-17 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000097',s27,cat11,'Request for on-campus dentist facility','Dental unit requires separate licence and infrastructure not currently available.','public','undone',f02,'2025-09-18 10:00:00+00'),
    ('40000000-0000-0000-0000-000000000098',s28,cat13,'Request to allow online submission of all applications','Some documents require physical signature under current university norms.','public','undone',f01,'2025-09-19 09:00:00+00'),
    ('40000000-0000-0000-0000-000000000099',s29,cat15,'Request for biometric entry system at campus gate','Biometric system procurement delayed. Under review by management committee.','public','undone',f03,'2025-09-20 08:00:00+00'),
    ('40000000-0000-0000-0000-000000000100',s30,cat01,'Request to convert open corridor to enclosed walkway','Civil work estimate too high. Will be considered in next financial year plan.','public','undone',f01,'2025-09-21 09:00:00+00')
  ON CONFLICT (id) DO NOTHING;

  -- ================================================================
  -- VOTES (students upvoting public complaints)
  -- ================================================================
  INSERT INTO public.votes (id,complaint_id,user_id) VALUES
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000031',s02),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000031',s18),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000031',s16),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000031',s15),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032',s07),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032',s35),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032',s06),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032',s38),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032',s28),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000033',s02),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000033',s06),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000033',s14),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034',s33),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034',s39),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034',s02),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034',s36),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034',s13),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034',s35),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s15),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s29),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s38),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s18),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s01),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s11),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s28),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s22),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035',s37),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036',s14),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036',s22),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036',s07),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036',s06),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036',s25),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000037',s23),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000037',s39),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000037',s17),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000037',s03),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s35),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s08),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s25),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s06),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s36),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s19),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s24),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s13),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s05),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038',s02),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039',s19),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039',s06),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039',s15),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039',s07),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039',s25),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039',s18),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s24),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s11),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s40),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s23),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s14),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s18),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s05),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s39),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s16),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040',s06),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s25),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s18),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s36),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s15),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s21),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s04),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s37),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s03),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s38),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041',s13),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042',s05),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042',s14),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042',s37),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042',s21),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042',s39),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042',s32),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042',s26),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s10),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s17),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s09),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s16),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s36),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s35),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s39),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s28),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s26),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043',s12),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044',s09),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044',s33),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044',s32),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044',s06),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044',s04),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044',s08),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045',s11),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045',s28),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045',s39),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045',s05),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045',s25),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s39),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s30),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s34),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s17),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s36),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s01),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s08),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s18),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046',s22),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000047',s19),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000047',s28),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000047',s11),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000047',s30),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000048',s17),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000048',s33),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000048',s12),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000049',s07),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000049',s20),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000049',s33),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000049',s13)
  ON CONFLICT (complaint_id,user_id) DO NOTHING;

  -- ================================================================
  -- STATUS LOG
  -- ================================================================
  INSERT INTO public.status_log (id,complaint_id,action_type,performed_by,timestamp) VALUES
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000031','submitted',s01,'2025-12-10 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000031','assigned',adm,'2025-12-10 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000031','status_changed_to_processing',f01,'2025-12-10 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032','submitted',s02,'2025-12-11 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032','assigned',adm,'2025-12-11 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000032','status_changed_to_processing',f02,'2025-12-11 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000033','submitted',s03,'2025-12-12 11:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000033','assigned',adm,'2025-12-12 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000033','status_changed_to_processing',f03,'2025-12-12 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034','submitted',s04,'2025-12-13 09:30:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034','assigned',adm,'2025-12-13 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000034','status_changed_to_processing',f04,'2025-12-13 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035','submitted',s05,'2025-12-14 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035','assigned',adm,'2025-12-14 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000035','status_changed_to_processing',f05,'2025-12-14 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036','submitted',s06,'2025-12-15 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036','assigned',adm,'2025-12-15 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000036','status_changed_to_processing',f01,'2025-12-15 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000037','submitted',s07,'2025-12-16 08:30:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000037','assigned',adm,'2025-12-16 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000037','status_changed_to_processing',f02,'2025-12-16 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038','submitted',s08,'2025-12-17 07:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038','assigned',adm,'2025-12-17 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000038','status_changed_to_processing',f03,'2025-12-17 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039','submitted',s09,'2025-12-18 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039','assigned',adm,'2025-12-18 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000039','status_changed_to_processing',f04,'2025-12-18 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040','submitted',s10,'2025-12-19 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040','assigned',adm,'2025-12-19 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000040','status_changed_to_processing',f05,'2025-12-19 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041','submitted',s11,'2025-12-20 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041','assigned',adm,'2025-12-20 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000041','status_changed_to_processing',f01,'2025-12-20 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042','submitted',s12,'2025-12-21 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042','assigned',adm,'2025-12-21 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000042','status_changed_to_processing',f02,'2025-12-21 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043','submitted',s13,'2025-12-22 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043','assigned',adm,'2025-12-22 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000043','status_changed_to_processing',f03,'2025-12-22 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044','submitted',s14,'2025-12-23 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044','assigned',adm,'2025-12-23 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000044','status_changed_to_processing',f04,'2025-12-23 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045','submitted',s15,'2025-12-24 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045','assigned',adm,'2025-12-24 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000045','status_changed_to_processing',f05,'2025-12-24 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046','submitted',s16,'2025-12-26 11:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046','assigned',adm,'2025-12-26 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000046','status_changed_to_processing',f01,'2025-12-26 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000047','submitted',s17,'2025-12-27 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000047','assigned',adm,'2025-12-27 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000047','status_changed_to_processing',f02,'2025-12-27 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000048','submitted',s18,'2025-12-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000048','assigned',adm,'2025-12-28 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000048','status_changed_to_processing',f03,'2025-12-28 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000049','submitted',s19,'2025-12-29 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000049','assigned',adm,'2025-12-29 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000049','status_changed_to_processing',f04,'2025-12-29 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000050','submitted',s20,'2025-12-30 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000050','assigned',adm,'2025-12-30 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000050','status_changed_to_processing',f05,'2025-12-30 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000051','submitted',s21,'2026-01-02 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000051','assigned',adm,'2026-01-02 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000051','status_changed_to_processing',f01,'2026-01-02 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000052','submitted',s22,'2026-01-03 13:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000052','assigned',adm,'2026-01-03 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000052','status_changed_to_processing',f02,'2026-01-03 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000053','submitted',s23,'2026-01-04 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000053','assigned',adm,'2026-01-04 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000053','status_changed_to_processing',f03,'2026-01-04 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000054','submitted',s24,'2026-01-05 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000054','assigned',adm,'2026-01-05 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000054','status_changed_to_processing',f04,'2026-01-05 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000055','submitted',s25,'2026-01-06 17:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000055','assigned',adm,'2026-01-06 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000055','status_changed_to_processing',f05,'2026-01-06 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000056','submitted',s26,'2026-01-07 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000056','assigned',adm,'2026-01-07 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000056','status_changed_to_processing',f01,'2026-01-07 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000057','submitted',s27,'2026-01-08 11:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000057','assigned',adm,'2026-01-08 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000057','status_changed_to_processing',f02,'2026-01-08 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000058','submitted',s28,'2026-01-09 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000058','assigned',adm,'2026-01-09 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000058','status_changed_to_processing',f03,'2026-01-09 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000059','submitted',s29,'2026-01-10 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000059','assigned',adm,'2026-01-10 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000059','status_changed_to_processing',f04,'2026-01-10 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000060','submitted',s30,'2026-01-11 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000060','assigned',adm,'2026-01-11 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000060','status_changed_to_processing',f05,'2026-01-11 14:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000061','submitted',s01,'2025-10-05 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000061','assigned',adm,'2025-10-05 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000061','status_changed_to_processing',f01,'2025-10-05 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000061','status_changed_to_done',f01,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000062','submitted',s02,'2025-10-07 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000062','assigned',adm,'2025-10-07 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000062','status_changed_to_processing',f02,'2025-10-07 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000062','status_changed_to_done',f02,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000063','submitted',s03,'2025-10-10 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000063','assigned',adm,'2025-10-10 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000063','status_changed_to_processing',f03,'2025-10-10 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000063','status_changed_to_done',f03,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000064','submitted',s04,'2025-10-12 11:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000064','assigned',adm,'2025-10-12 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000064','status_changed_to_processing',f04,'2025-10-12 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000064','status_changed_to_done',f04,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000065','submitted',s05,'2025-10-14 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000065','assigned',adm,'2025-10-14 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000065','status_changed_to_processing',f05,'2025-10-14 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000065','status_changed_to_done',f05,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000066','submitted',s06,'2025-10-16 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000066','assigned',adm,'2025-10-16 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000066','status_changed_to_processing',f01,'2025-10-16 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000066','status_changed_to_done',f01,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000067','submitted',s07,'2025-10-18 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000067','assigned',adm,'2025-10-18 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000067','status_changed_to_processing',f02,'2025-10-18 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000067','status_changed_to_done',f02,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000068','submitted',s08,'2025-10-20 07:30:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000068','assigned',adm,'2025-10-20 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000068','status_changed_to_processing',f03,'2025-10-20 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000068','status_changed_to_done',f03,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000069','submitted',s09,'2025-10-22 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000069','assigned',adm,'2025-10-22 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000069','status_changed_to_processing',f04,'2025-10-22 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000069','status_changed_to_done',f04,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000070','submitted',s10,'2025-10-24 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000070','assigned',adm,'2025-10-24 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000070','status_changed_to_processing',f05,'2025-10-24 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000070','status_changed_to_done',f05,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000071','submitted',s11,'2025-10-26 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000071','assigned',adm,'2025-10-26 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000071','status_changed_to_processing',f01,'2025-10-26 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000071','status_changed_to_done',f01,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000072','submitted',s12,'2025-10-28 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000072','assigned',adm,'2025-10-28 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000072','status_changed_to_processing',f02,'2025-10-28 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000072','status_changed_to_done',f02,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000073','submitted',s13,'2025-10-30 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000073','assigned',adm,'2025-10-30 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000073','status_changed_to_processing',f03,'2025-10-30 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000073','status_changed_to_done',f03,'2025-10-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000074','submitted',s14,'2025-11-01 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000074','assigned',adm,'2025-11-01 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000074','status_changed_to_processing',f04,'2025-11-01 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000074','status_changed_to_done',f04,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000075','submitted',s15,'2025-11-03 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000075','assigned',adm,'2025-11-03 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000075','status_changed_to_processing',f05,'2025-11-03 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000075','status_changed_to_done',f05,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000076','submitted',s16,'2025-11-05 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000076','assigned',adm,'2025-11-05 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000076','status_changed_to_processing',f01,'2025-11-05 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000076','status_changed_to_done',f01,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000077','submitted',s17,'2025-11-07 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000077','assigned',adm,'2025-11-07 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000077','status_changed_to_processing',f02,'2025-11-07 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000077','status_changed_to_done',f02,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000078','submitted',s18,'2025-11-09 11:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000078','assigned',adm,'2025-11-09 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000078','status_changed_to_processing',f03,'2025-11-09 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000078','status_changed_to_done',f03,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000079','submitted',s19,'2025-11-10 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000079','assigned',adm,'2025-11-10 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000079','status_changed_to_processing',f04,'2025-11-10 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000079','status_changed_to_done',f04,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000080','submitted',s20,'2025-11-12 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000080','assigned',adm,'2025-11-12 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000080','status_changed_to_processing',f05,'2025-11-12 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000080','status_changed_to_done',f05,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000081','submitted',s21,'2025-11-14 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000081','assigned',adm,'2025-11-14 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000081','status_changed_to_processing',f01,'2025-11-14 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000081','status_changed_to_done',f01,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000082','submitted',s22,'2025-11-16 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000082','assigned',adm,'2025-11-16 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000082','status_changed_to_processing',f02,'2025-11-16 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000082','status_changed_to_done',f02,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000083','submitted',s23,'2025-11-18 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000083','assigned',adm,'2025-11-18 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000083','status_changed_to_processing',f03,'2025-11-18 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000083','status_changed_to_done',f03,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000084','submitted',s24,'2025-11-20 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000084','assigned',adm,'2025-11-20 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000084','status_changed_to_processing',f04,'2025-11-20 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000084','status_changed_to_done',f04,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000085','submitted',s25,'2025-11-22 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000085','assigned',adm,'2025-11-22 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000085','status_changed_to_processing',f05,'2025-11-22 15:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000085','status_changed_to_done',f05,'2025-11-20 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000086','submitted',s01,'2025-09-05 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000086','assigned',adm,'2025-09-05 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000086','status_changed_to_undone',f01,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000087','submitted',s02,'2025-09-07 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000087','assigned',adm,'2025-09-07 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000087','status_changed_to_undone',f02,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000088','submitted',s03,'2025-09-09 11:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000088','assigned',adm,'2025-09-09 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000088','status_changed_to_undone',f03,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000089','submitted',s04,'2025-09-10 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000089','assigned',adm,'2025-09-10 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000089','status_changed_to_undone',f04,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000090','submitted',s05,'2025-09-11 07:30:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000090','assigned',adm,'2025-09-11 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000090','status_changed_to_undone',f05,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000091','submitted',s06,'2025-09-12 18:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000091','assigned',adm,'2025-09-12 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000091','status_changed_to_undone',f01,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000092','submitted',s07,'2025-09-13 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000092','assigned',adm,'2025-09-13 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000092','status_changed_to_undone',f02,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000093','submitted',s08,'2025-09-14 11:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000093','assigned',adm,'2025-09-14 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000093','status_changed_to_undone',f03,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000094','submitted',s09,'2025-09-15 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000094','assigned',adm,'2025-09-15 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000094','status_changed_to_undone',f04,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000095','submitted',s10,'2025-09-16 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000095','assigned',adm,'2025-09-16 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000095','status_changed_to_undone',f05,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000096','submitted',s11,'2025-09-17 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000096','assigned',adm,'2025-09-17 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000096','status_changed_to_undone',f01,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000097','submitted',s12,'2025-09-18 10:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000097','assigned',adm,'2025-09-18 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000097','status_changed_to_undone',f02,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000098','submitted',s13,'2025-09-19 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000098','assigned',adm,'2025-09-19 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000098','status_changed_to_undone',f03,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000099','submitted',s14,'2025-09-20 08:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000099','assigned',adm,'2025-09-20 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000099','status_changed_to_undone',f04,'2025-09-28 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000100','submitted',s15,'2025-09-21 09:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000100','assigned',adm,'2025-09-21 12:00:00+00'),
    (gen_random_uuid(),'40000000-0000-0000-0000-000000000100','status_changed_to_undone',f05,'2025-09-28 09:00:00+00')
  ;

  -- ================================================================
  -- NOTIFICATIONS
  -- ================================================================
  INSERT INTO public.notifications (id,user_id,complaint_id,message,is_read,created_at) VALUES
    (gen_random_uuid(),s01,'40000000-0000-0000-0000-000000000031','Your complaint "Paint peeling on Block A 3rd floor corri..." is now being processed.',false,'2025-12-10 14:30:00+00'),
    (gen_random_uuid(),f01,'40000000-0000-0000-0000-000000000031','A new complaint has been assigned to you: "Paint peeling on Block A 3rd floor corri..."',false,'2025-12-10 12:30:00+00'),
    (gen_random_uuid(),s02,'40000000-0000-0000-0000-000000000032','Your complaint "Hostel common room TV not functioning fo..." is now being processed.',false,'2025-12-11 14:30:00+00'),
    (gen_random_uuid(),f02,'40000000-0000-0000-0000-000000000032','A new complaint has been assigned to you: "Hostel common room TV not functioning fo..."',false,'2025-12-11 12:30:00+00'),
    (gen_random_uuid(),s03,'40000000-0000-0000-0000-000000000033','Your complaint "Online journal access broken on library ..." is now being processed.',false,'2025-12-12 14:30:00+00'),
    (gen_random_uuid(),f03,'40000000-0000-0000-0000-000000000033','A new complaint has been assigned to you: "Online journal access broken on library ..."',false,'2025-12-12 12:30:00+00'),
    (gen_random_uuid(),s04,'40000000-0000-0000-0000-000000000034','Your complaint "Python 3 not installed on Lab 3 PCs..." is now being processed.',false,'2025-12-13 14:30:00+00'),
    (gen_random_uuid(),f04,'40000000-0000-0000-0000-000000000034','A new complaint has been assigned to you: "Python 3 not installed on Lab 3 PCs..."',false,'2025-12-13 12:30:00+00'),
    (gen_random_uuid(),s05,'40000000-0000-0000-0000-000000000035','Your complaint "No substitute assigned for Prof. on medi..." is now being processed.',false,'2025-12-14 14:30:00+00'),
    (gen_random_uuid(),f05,'40000000-0000-0000-0000-000000000035','A new complaint has been assigned to you: "No substitute assigned for Prof. on medi..."',false,'2025-12-14 12:30:00+00'),
    (gen_random_uuid(),s06,'40000000-0000-0000-0000-000000000036','Your complaint "Internal assessment marks not published ..." is now being processed.',false,'2025-12-15 14:30:00+00'),
    (gen_random_uuid(),f01,'40000000-0000-0000-0000-000000000036','A new complaint has been assigned to you: "Internal assessment marks not published ..."',false,'2025-12-15 12:30:00+00'),
    (gen_random_uuid(),s07,'40000000-0000-0000-0000-000000000037','Your complaint "Drinking water cooler on 2nd floor not w..." is now being processed.',false,'2025-12-16 14:30:00+00'),
    (gen_random_uuid(),f02,'40000000-0000-0000-0000-000000000037','A new complaint has been assigned to you: "Drinking water cooler on 2nd floor not w..."',false,'2025-12-16 12:30:00+00'),
    (gen_random_uuid(),s08,'40000000-0000-0000-0000-000000000038','Your complaint "Bus driver overspeeding on highway stret..." is now being processed.',false,'2025-12-17 14:30:00+00'),
    (gen_random_uuid(),f03,'40000000-0000-0000-0000-000000000038','A new complaint has been assigned to you: "Bus driver overspeeding on highway stret..."',false,'2025-12-17 12:30:00+00'),
    (gen_random_uuid(),s09,'40000000-0000-0000-0000-000000000039','Your complaint "College website down every Monday mornin..." is now being processed.',false,'2025-12-18 14:30:00+00'),
    (gen_random_uuid(),f04,'40000000-0000-0000-0000-000000000039','A new complaint has been assigned to you: "College website down every Monday mornin..."',false,'2025-12-18 12:30:00+00'),
    (gen_random_uuid(),s10,'40000000-0000-0000-0000-000000000040','Your complaint "Cricket pitch not maintained — full of w..." is now being processed.',false,'2025-12-19 14:30:00+00'),
    (gen_random_uuid(),f05,'40000000-0000-0000-0000-000000000040','A new complaint has been assigned to you: "Cricket pitch not maintained — full of w..."',false,'2025-12-19 12:30:00+00'),
    (gen_random_uuid(),s11,'40000000-0000-0000-0000-000000000041','Your complaint "Ambulance not available during weekend h..." is now being processed.',false,'2025-12-20 14:30:00+00'),
    (gen_random_uuid(),f01,'40000000-0000-0000-0000-000000000041','A new complaint has been assigned to you: "Ambulance not available during weekend h..."',false,'2025-12-20 12:30:00+00'),
    (gen_random_uuid(),s12,'40000000-0000-0000-0000-000000000042','Your complaint "National scholarship portal OTP not deli..." is now being processed.',false,'2025-12-21 14:30:00+00'),
    (gen_random_uuid(),f02,'40000000-0000-0000-0000-000000000042','A new complaint has been assigned to you: "National scholarship portal OTP not deli..."',false,'2025-12-21 12:30:00+00'),
    (gen_random_uuid(),s13,'40000000-0000-0000-0000-000000000043','Your complaint "Duplicate marksheet request pending for ..." is now being processed.',false,'2025-12-22 14:30:00+00'),
    (gen_random_uuid(),f03,'40000000-0000-0000-0000-000000000043','A new complaint has been assigned to you: "Duplicate marksheet request pending for ..."',false,'2025-12-22 12:30:00+00'),
    (gen_random_uuid(),s14,'40000000-0000-0000-0000-000000000044','Your complaint "Girls washroom door lock broken on Block..." is now being processed.',false,'2025-12-23 14:30:00+00'),
    (gen_random_uuid(),f04,'40000000-0000-0000-0000-000000000044','A new complaint has been assigned to you: "Girls washroom door lock broken on Block..."',false,'2025-12-23 12:30:00+00'),
    (gen_random_uuid(),s15,'40000000-0000-0000-0000-000000000045','Your complaint "Visitor register not maintained at secur..." is now being processed.',false,'2025-12-24 14:30:00+00'),
    (gen_random_uuid(),f05,'40000000-0000-0000-0000-000000000045','A new complaint has been assigned to you: "Visitor register not maintained at secur..."',false,'2025-12-24 12:30:00+00'),
    (gen_random_uuid(),s16,'40000000-0000-0000-0000-000000000046','Your complaint "Electrical short circuit in Block B corr..." is now being processed.',false,'2025-12-26 14:30:00+00'),
    (gen_random_uuid(),f01,'40000000-0000-0000-0000-000000000046','A new complaint has been assigned to you: "Electrical short circuit in Block B corr..."',false,'2025-12-26 12:30:00+00'),
    (gen_random_uuid(),s17,'40000000-0000-0000-0000-000000000047','Your complaint "Mosquito nets not provided in hostel roo..." is now being processed.',false,'2025-12-27 14:30:00+00'),
    (gen_random_uuid(),f02,'40000000-0000-0000-0000-000000000047','A new complaint has been assigned to you: "Mosquito nets not provided in hostel roo..."',false,'2025-12-27 12:30:00+00'),
    (gen_random_uuid(),s18,'40000000-0000-0000-0000-000000000048','Your complaint "Study hall chairs broken and unstable..." is now being processed.',false,'2025-12-28 14:30:00+00'),
    (gen_random_uuid(),f03,'40000000-0000-0000-0000-000000000048','A new complaint has been assigned to you: "Study hall chairs broken and unstable..."',false,'2025-12-28 12:30:00+00'),
    (gen_random_uuid(),s19,'40000000-0000-0000-0000-000000000049','Your complaint "Printer in Computer Lab 2 out of service..." is now being processed.',false,'2025-12-29 14:30:00+00'),
    (gen_random_uuid(),f04,'40000000-0000-0000-0000-000000000049','A new complaint has been assigned to you: "Printer in Computer Lab 2 out of service..."',false,'2025-12-29 12:30:00+00'),
    (gen_random_uuid(),s20,'40000000-0000-0000-0000-000000000050','Your complaint "CS8301 course material not distributed..." is now being processed.',false,'2025-12-30 14:30:00+00'),
    (gen_random_uuid(),f05,'40000000-0000-0000-0000-000000000050','A new complaint has been assigned to you: "CS8301 course material not distributed..."',false,'2025-12-30 12:30:00+00'),
    (gen_random_uuid(),s21,'40000000-0000-0000-0000-000000000051','Your complaint "Exam hall seating uncomfortably cramped..." is now being processed.',false,'2026-01-02 14:30:00+00'),
    (gen_random_uuid(),f01,'40000000-0000-0000-0000-000000000051','A new complaint has been assigned to you: "Exam hall seating uncomfortably cramped..."',false,'2026-01-02 12:30:00+00'),
    (gen_random_uuid(),s22,'40000000-0000-0000-0000-000000000052','Your complaint "No vegetarian option at canteen after 1 ..." is now being processed.',false,'2026-01-03 14:30:00+00'),
    (gen_random_uuid(),f02,'40000000-0000-0000-0000-000000000052','A new complaint has been assigned to you: "No vegetarian option at canteen after 1 ..."',false,'2026-01-03 12:30:00+00'),
    (gen_random_uuid(),s23,'40000000-0000-0000-0000-000000000053','Your complaint "Bus overcrowded — students standing dang..." is now being processed.',false,'2026-01-04 14:30:00+00'),
    (gen_random_uuid(),f03,'40000000-0000-0000-0000-000000000053','A new complaint has been assigned to you: "Bus overcrowded — students standing dang..."',false,'2026-01-04 12:30:00+00'),
    (gen_random_uuid(),s24,'40000000-0000-0000-0000-000000000054','Your complaint "LAN cables in Block D classroom damaged..." is now being processed.',false,'2026-01-05 14:30:00+00'),
    (gen_random_uuid(),f04,'40000000-0000-0000-0000-000000000054','A new complaint has been assigned to you: "LAN cables in Block D classroom damaged..."',false,'2026-01-05 12:30:00+00'),
    (gen_random_uuid(),s25,'40000000-0000-0000-0000-000000000055','Your complaint "Badminton court flood light fused — unus..." is now being processed.',false,'2026-01-06 14:30:00+00'),
    (gen_random_uuid(),f05,'40000000-0000-0000-0000-000000000055','A new complaint has been assigned to you: "Badminton court flood light fused — unus..."',false,'2026-01-06 12:30:00+00'),
    (gen_random_uuid(),s26,'40000000-0000-0000-0000-000000000056','Your complaint "Eye-wash station in Chemistry Lab not fu..." is now being processed.',false,'2026-01-07 14:30:00+00'),
    (gen_random_uuid(),f01,'40000000-0000-0000-0000-000000000056','A new complaint has been assigned to you: "Eye-wash station in Chemistry Lab not fu..."',false,'2026-01-07 12:30:00+00'),
    (gen_random_uuid(),s27,'40000000-0000-0000-0000-000000000057','Your complaint "SC/ST scholarship form not available at ..." is now being processed.',false,'2026-01-08 14:30:00+00'),
    (gen_random_uuid(),f02,'40000000-0000-0000-0000-000000000057','A new complaint has been assigned to you: "SC/ST scholarship form not available at ..."',false,'2026-01-08 12:30:00+00'),
    (gen_random_uuid(),s28,'40000000-0000-0000-0000-000000000058','Your complaint "Migration certificate delayed — admissio..." is now being processed.',false,'2026-01-09 14:30:00+00'),
    (gen_random_uuid(),f03,'40000000-0000-0000-0000-000000000058','A new complaint has been assigned to you: "Migration certificate delayed — admissio..."',false,'2026-01-09 12:30:00+00'),
    (gen_random_uuid(),s29,'40000000-0000-0000-0000-000000000059','Your complaint "Dustbins absent from all classroom corri..." is now being processed.',false,'2026-01-10 14:30:00+00'),
    (gen_random_uuid(),f04,'40000000-0000-0000-0000-000000000059','A new complaint has been assigned to you: "Dustbins absent from all classroom corri..."',false,'2026-01-10 12:30:00+00'),
    (gen_random_uuid(),s30,'40000000-0000-0000-0000-000000000060','Your complaint "Bike parking area has no security at nig..." is now being processed.',false,'2026-01-11 14:30:00+00'),
    (gen_random_uuid(),f05,'40000000-0000-0000-0000-000000000060','A new complaint has been assigned to you: "Bike parking area has no security at nig..."',false,'2026-01-11 12:30:00+00'),
    (gen_random_uuid(),s01,'40000000-0000-0000-0000-000000000061','Great news! Your complaint "Main entrance gate floodlight repaired..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s02,'40000000-0000-0000-0000-000000000062','Great news! Your complaint "Hot water restored in Girls Hostel Block..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s03,'40000000-0000-0000-0000-000000000063','Great news! Your complaint "New copies of DBMS textbook procured..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s04,'40000000-0000-0000-0000-000000000064','Great news! Your complaint "Oscilloscope in ECE Lab 2 calibrated and..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s05,'40000000-0000-0000-0000-000000000065','Great news! Your complaint "Substitute assigned for absent Maths pro..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s06,'40000000-0000-0000-0000-000000000066','Great news! Your complaint "Internal marks published on student port..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s07,'40000000-0000-0000-0000-000000000067','Great news! Your complaint "Canteen hygiene improved after inspectio..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s08,'40000000-0000-0000-0000-000000000068','Great news! Your complaint "Route 1 bus timing corrected to 7:55 AM..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s09,'40000000-0000-0000-0000-000000000069','Great news! Your complaint "WiFi access points replaced in Block C..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s10,'40000000-0000-0000-0000-000000000070','Great news! Your complaint "Football goal posts repainted and nets r..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s11,'40000000-0000-0000-0000-000000000071','Great news! Your complaint "Medical room staffed on all working days..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s12,'40000000-0000-0000-0000-000000000072','Great news! Your complaint "Scholarship disbursement completed for a..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s13,'40000000-0000-0000-0000-000000000073','Great news! Your complaint "Bonafide certificate same-day issuance r..." has been resolved.',true,'2025-10-20 09:30:00+00'),
    (gen_random_uuid(),s14,'40000000-0000-0000-0000-000000000074','Great news! Your complaint "Washrooms in Block A deep-cleaned and re..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s15,'40000000-0000-0000-0000-000000000075','Great news! Your complaint "CCTV system overhauled — 12 new cameras ..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s16,'40000000-0000-0000-0000-000000000076','Great news! Your complaint "Roof leakage in Block A sealed before mo..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s17,'40000000-0000-0000-0000-000000000077','Great news! Your complaint "Hostel room locks replaced in Block D..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s18,'40000000-0000-0000-0000-000000000078','Great news! Your complaint "Software tools updated across all CS lab..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s19,'40000000-0000-0000-0000-000000000079','Great news! Your complaint "New canteen vendor appointed after quali..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s20,'40000000-0000-0000-0000-000000000080','Great news! Your complaint "Additional bus added on Route 3 morning ..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s21,'40000000-0000-0000-0000-000000000081','Great news! Your complaint "Student portal upgraded — submissions wo..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s22,'40000000-0000-0000-0000-000000000082','Great news! Your complaint "Quiet study zone created in library firs..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s23,'40000000-0000-0000-0000-000000000083','Great news! Your complaint "Volleyball court net and poles replaced..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s24,'40000000-0000-0000-0000-000000000084','Great news! Your complaint "First aid kits restocked in all labs..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s25,'40000000-0000-0000-0000-000000000085','Great news! Your complaint "TC issuance turnaround reduced to 5 work..." has been resolved.',true,'2025-11-20 09:30:00+00'),
    (gen_random_uuid(),s01,'40000000-0000-0000-0000-000000000086','Your complaint "Request to install AC in Block A classro..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s02,'40000000-0000-0000-0000-000000000087','Your complaint "Request for individual study tables in h..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s03,'40000000-0000-0000-0000-000000000088','Your complaint "Request to extend library hours to midni..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s04,'40000000-0000-0000-0000-000000000089','Your complaint "Request to record and upload all lecture..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s05,'40000000-0000-0000-0000-000000000090','Your complaint "Request for college bus from Edappally j..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s06,'40000000-0000-0000-0000-000000000091','Your complaint "Request for subsidised dinner at canteen..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s07,'40000000-0000-0000-0000-000000000092','Your complaint "Request to build a swimming pool on camp..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s08,'40000000-0000-0000-0000-000000000093','Your complaint "Request for 100 Mbps dedicated WiFi in h..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s09,'40000000-0000-0000-0000-000000000094','Your complaint "Request to waive exam fee for all re-app..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s10,'40000000-0000-0000-0000-000000000095','Your complaint "Request to shift end-semester exam dates..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s11,'40000000-0000-0000-0000-000000000096','Your complaint "Request for scented disinfectant in wash..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s12,'40000000-0000-0000-0000-000000000097','Your complaint "Request for on-campus dentist facility..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s13,'40000000-0000-0000-0000-000000000098','Your complaint "Request to allow online submission of al..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s14,'40000000-0000-0000-0000-000000000099','Your complaint "Request for biometric entry system at ca..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00'),
    (gen_random_uuid(),s15,'40000000-0000-0000-0000-000000000100','Your complaint "Request to convert open corridor to encl..." could not be resolved at this time.',true,'2025-09-28 09:30:00+00')
  ;
END $$;

-- =====================================================================
-- VERIFICATION QUERIES — Run these after the script to confirm data
-- =====================================================================
SELECT role, approval_status, COUNT(*) AS count
  FROM public.profiles
 GROUP BY role, approval_status
 ORDER BY role, approval_status;

SELECT status, COUNT(*) AS count
  FROM public.complaints
 GROUP BY status
 ORDER BY status;

SELECT c.name AS category, p.name AS faculty
  FROM public.category_faculty cf
  JOIN public.categories c ON c.id = cf.category_id
  JOIN public.profiles   p ON p.id = cf.faculty_id
 ORDER BY c.name;
