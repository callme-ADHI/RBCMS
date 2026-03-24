-- =============================================================
-- RBCMS Admin Setup Script
-- Run this in: Supabase Dashboard → SQL Editor
--
-- This script creates (or updates) the two admin accounts:
--   1. adhithyakrishna00001@gmail.com
--   2. asharaj@mgits.ac.in
-- Both with password: Admin@1234
-- =============================================================

-- Step 1: Create/confirm users in auth.users with hashed password
-- (Uses Supabase's built-in crypt via pgcrypto)

DO $$
DECLARE
  uid1 uuid;
  uid2 uuid;
BEGIN

  -- ── Admin 1: adhithyakrishna00001@gmail.com ──────────────────
  SELECT id INTO uid1
    FROM auth.users
   WHERE email = 'adhithyakrishna00001@gmail.com';

  IF uid1 IS NULL THEN
    uid1 := gen_random_uuid();
    INSERT INTO auth.users (
      id,
      instance_id,
      email,
      encrypted_password,
      email_confirmed_at,
      created_at,
      updated_at,
      raw_app_meta_data,
      raw_user_meta_data,
      is_super_admin,
      role,
      aud
    ) VALUES (
      uid1,
      '00000000-0000-0000-0000-000000000000',
      'adhithyakrishna00001@gmail.com',
      crypt('Admin@1234', gen_salt('bf')),
      now(),
      now(),
      now(),
      '{"provider":"email","providers":["email"]}',
      '{"name":"Admin","role":"admin"}',
      false,
      'authenticated',
      'authenticated'
    );
    RAISE NOTICE 'Created auth user: adhithyakrishna00001@gmail.com (id: %)', uid1;
  ELSE
    -- Update password if account already exists
    UPDATE auth.users
       SET encrypted_password = crypt('Admin@1234', gen_salt('bf')),
           email_confirmed_at = COALESCE(email_confirmed_at, now()),
           updated_at = now(),
           raw_user_meta_data = '{"name":"Admin","role":"admin"}'
     WHERE id = uid1;
    RAISE NOTICE 'Updated auth user: adhithyakrishna00001@gmail.com (id: %)', uid1;
  END IF;

  -- Upsert profile for Admin 1
  INSERT INTO public.profiles (id, name, email, role, approval_status, created_at)
  VALUES (uid1, 'Admin', 'adhithyakrishna00001@gmail.com', 'admin', 'approved', now())
  ON CONFLICT (id) DO UPDATE
    SET role            = 'admin',
        approval_status = 'approved',
        email           = 'adhithyakrishna00001@gmail.com',
        name            = COALESCE(NULLIF(public.profiles.name, ''), 'Admin');


  -- ── Admin 2: asharaj@mgits.ac.in ─────────────────────────────
  SELECT id INTO uid2
    FROM auth.users
   WHERE email = 'asharaj@mgits.ac.in';

  IF uid2 IS NULL THEN
    uid2 := gen_random_uuid();
    INSERT INTO auth.users (
      id,
      instance_id,
      email,
      encrypted_password,
      email_confirmed_at,
      created_at,
      updated_at,
      raw_app_meta_data,
      raw_user_meta_data,
      is_super_admin,
      role,
      aud
    ) VALUES (
      uid2,
      '00000000-0000-0000-0000-000000000000',
      'asharaj@mgits.ac.in',
      crypt('Admin@1234', gen_salt('bf')),
      now(),
      now(),
      now(),
      '{"provider":"email","providers":["email"]}',
      '{"name":"Asha Raj","role":"admin"}',
      false,
      'authenticated',
      'authenticated'
    );
    RAISE NOTICE 'Created auth user: asharaj@mgits.ac.in (id: %)', uid2;
  ELSE
    UPDATE auth.users
       SET encrypted_password = crypt('Admin@1234', gen_salt('bf')),
           email_confirmed_at = COALESCE(email_confirmed_at, now()),
           updated_at = now(),
           raw_user_meta_data = '{"name":"Asha Raj","role":"admin"}'
     WHERE id = uid2;
    RAISE NOTICE 'Updated auth user: asharaj@mgits.ac.in (id: %)', uid2;
  END IF;

  -- Upsert profile for Admin 2
  INSERT INTO public.profiles (id, name, email, role, approval_status, created_at)
  VALUES (uid2, 'Asha Raj', 'asharaj@mgits.ac.in', 'admin', 'approved', now())
  ON CONFLICT (id) DO UPDATE
    SET role            = 'admin',
        approval_status = 'approved',
        email           = 'asharaj@mgits.ac.in',
        name            = COALESCE(NULLIF(public.profiles.name, ''), 'Asha Raj');

END $$;

-- =============================================================
-- Verify: run this SELECT after to confirm both admins exist
-- =============================================================
SELECT
  u.email,
  p.name,
  p.role,
  p.approval_status,
  u.email_confirmed_at IS NOT NULL AS email_confirmed
FROM auth.users u
JOIN public.profiles p ON p.id = u.id
WHERE u.email IN (
  'adhithyakrishna00001@gmail.com',
  'asharaj@mgits.ac.in'
);
