# VetClinic — Lab 8

A veterinary clinic management application built with Ruby on Rails.

## Authentication

Authentication is **required** to access all VetClinic resource pages (owners, pets, vets, appointments, treatments). The home page (`/`) is public.

Authentication is handled by [Devise](https://github.com/heartcombo/devise).

## Seeded Users

Run `bin/rails db:drop db:create db:migrate db:seed` to set up the database with the following users:

| Role  | Email                  | Password    |
|-------|------------------------|-------------|
| Admin | admin@vetclinic.com    | password123 |
| Vet   | vet@vetclinic.com      | password123 |
| Owner | owner@vetclinic.com    | password123 |

## Notes

- The `role` field is stored on the User model as an integer enum (owner: 0, vet: 1, admin: 2). It is **not** assignable from any user-facing form — role assignment happens only via seeds or the Rails console.
- Flash messages (sign-in, sign-out, errors) use the shared `layouts/_flash` partial from Lab 5.
- Devise views are styled with Bootstrap 5, consistent with the rest of the application.
- After sign-up, the user is automatically signed in (Devise default behavior).
- Sign-out uses the DELETE HTTP verb via `button_to`.