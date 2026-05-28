# VetClinic

VetClinic now enforces authorization with Pundit. Admin users can manage every resource. Vet users can read all owners, pets, and vets, but they can only manage appointments and treatments assigned to themselves, and they can edit only their own Vet record. Owner users can manage only their own Owner record, only their own pets, and only appointments belonging to their pets. Treatments are only manageable through the appointment they belong to.

## Seeded users

### Admin
- admin@vetclinic.com / password123

### Vets
- vet@vetclinic.com / password123
- vet2@vetclinic.com / password123

### Owners
- owner@vetclinic.com / password123
- owner2@vetclinic.com / password123

## Notes

- User self-registration is disabled.
- Owners and vets are linked to their business records through `user_id`.
- The app is designed so `db:drop db:create db:migrate db:seed` works on a fresh database.