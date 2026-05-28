Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Vet.destroy_all
Owner.destroy_all
User.destroy_all

# Users
admin_user = User.create!(
  first_name: "Admin",
  last_name: "VetClinic",
  email: "admin@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

vet_user = User.create!(
  first_name: "Vannia",
  last_name: "Atria",
  email: "vet@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :vet
)

vet_user2 = User.create!(
  first_name: "Mauricio",
  last_name: "Rivera",
  email: "vet2@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :vet
)

owner_user = User.create!(
  first_name: "Damian",
  last_name: "Vega",
  email: "owner@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :owner
)

owner_user2 = User.create!(
  first_name: "Benjamin",
  last_name: "Quintana",
  email: "owner2@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :owner
)

# Vets
dra_atria = Vet.create!(
  first_name: "Vannia",
  last_name: "Atria",
  email: "vanniaatria@gmail.com",
  phone: "987654321",
  specialization: "Surgery",
  user: vet_user
)

dr_rivera = Vet.create!(
  first_name: "Mauricio",
  last_name: "Rivera",
  email: "mauricioh126@gmail.com",
  phone: "956032856",
  specialization: "General Medicine",
  user: vet_user2
)

# Owners
damian = Owner.create!(
  first_name: "Damian",
  last_name: "Vega",
  email: "devega@gmail.com",
  phone: "954227287",
  address: "Dos. Nte. 1021, Lo Barnechea",
  user: owner_user
)

benjamin = Owner.create!(
  first_name: "Benjamin",
  last_name: "Quintana",
  email: "benjaminquintanasilva24@gmail.com",
  phone: "978793796",
  address: "1701 Hipodromo Chile",
  user: owner_user2
)

manuel = Owner.create!(
  first_name: "Manuel",
  last_name: "Parada",
  email: "manuelparada@gmail.com",
  phone: "987227271",
  address: "Calle Samuel Izquierdo 2193, Quinta Normal"
)

# Pets
niki = damian.pets.create!(
  name: "Niki",
  species: "dog",
  breed: "Terranova",
  date_of_birth: Date.new(2012, 5, 20),
  weight: 30.0
)

lili = benjamin.pets.create!(
  name: "Liliana Estefania Ernesto Matilde",
  species: "cat",
  breed: "Marte",
  date_of_birth: Date.new(2024, 10, 12),
  weight: 5.0
)

judy = manuel.pets.create!(
  name: "Judy Hopps",
  species: "rabbit",
  breed: "Angora",
  date_of_birth: Date.new(2020, 3, 15),
  weight: 2.5
)

lulu = benjamin.pets.create!(
  name: "Lulu",
  species: "cat",
  breed: "Siberian",
  date_of_birth: Date.new(2019, 1, 24),
  weight: 4.5
)

capuchina = manuel.pets.create!(
  name: "Capuchina",
  species: "cat",
  breed: "Carey",
  date_of_birth: Date.new(2024, 2, 20),
  weight: 3.0
)

# Attach pet images safely
[
  [niki, "db/seeds/pets/dog.jpg", "image/jpeg"],
  [lili, "db/seeds/pets/cat.jpg", "image/jpeg"],
  [judy, "db/seeds/pets/rabbit.jpg", "image/jpeg"]
].each do |pet, path, type|

  full_path = Rails.root.join(path)

  if File.exist?(full_path)
    pet.photo.attach(
      io: File.open(full_path),
      filename: File.basename(path),
      content_type: type
    )

    puts "Image attached to #{pet.name}"
  else
    puts "Image not found: #{full_path}"
  end
end

# Appointments
app1 = Appointment.create!(
  pet: niki,
  vet: dra_atria,
  date: DateTime.new(2024, 7, 15, 10, 0),
  reason: "General checkup",
  status: :completed
)

app2 = Appointment.create!(
  pet: lili,
  vet: dr_rivera,
  date: DateTime.new(2024, 7, 16, 14, 30),
  reason: "Vaccination",
  status: :in_progress
)

app3 = Appointment.create!(
  pet: judy,
  vet: dra_atria,
  date: DateTime.new(2024, 7, 17, 9, 0),
  reason: "Digestive issues",
  status: :scheduled
)

app4 = Appointment.create!(
  pet: lulu,
  vet: dr_rivera,
  date: DateTime.new(2024, 7, 18, 11, 0),
  reason: "Dental checkup",
  status: :completed
)

app5 = Appointment.create!(
  pet: capuchina,
  vet: dra_atria,
  date: DateTime.new(2024, 7, 19, 15, 0),
  reason: "General checkup",
  status: :in_progress
)

# Treatments
app1.treatments.create!(
  name: "Deworming",
  medication: "Drontal",
  dosage: "1 tablet every 3 months",
  clinical_notes: "Patient responded well to treatment. Monitor stool for 48h. Repeat in 3 months.",
  administered_at: DateTime.new(2024, 7, 15, 10, 30)
)

app2.treatments.create!(
  name: "Rabies vaccine",
  medication: "Rabvac 3",
  dosage: "1 annual dose",
  clinical_notes: "Annual rabies vaccine administered without complications. Repeat yearly. Monitor for 24h post-vaccine.",
  administered_at: DateTime.new(2024, 7, 16, 15, 0)
)

app3.treatments.create!(
  name: "Digestive treatment",
  medication: "Fortiflora",
  dosage: "1 sachet daily for 7 days",
  clinical_notes: "Patient showing signs of mild gastritis. Administer 1 sachet daily with food. Review in one week.",
  administered_at: DateTime.new(2024, 7, 17, 9, 30)
)

app4.treatments.create!(
  name: "Dental cleaning",
  medication: "Ultrasound",
  dosage: "Single procedure",
  clinical_notes: "Procedure completed successfully under local sedation. Mild tartar buildup removed. Review every 6 months.",
  administered_at: DateTime.new(2024, 7, 18, 11, 30)
)

app5.treatments.create!(
  name: "General checkup",
  medication: "N/A",
  dosage: "N/A",
  clinical_notes: "Patient is in excellent health. Weight within normal range. Repeat yearly checkup.",
  administered_at: DateTime.new(2024, 7, 19, 15, 30)
)

puts "Seeds completed successfully!"
puts "Users:        #{User.count}"
puts "Owners:       #{Owner.count}"
puts "Vets:         #{Vet.count}"
puts "Pets:         #{Pet.count}"
puts "Appointments: #{Appointment.count}"
puts "Treatments:   #{Treatment.count}"