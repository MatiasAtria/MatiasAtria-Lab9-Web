require "test_helper"

class TreatmentTest < ActiveSupport::TestCase
  test "valid treatment can be saved" do
    treatment = build_treatment

    assert treatment.save
  end

  test "name is required" do
    treatment = build_treatment(name: nil)

    assert_not treatment.valid?
    assert_includes treatment.errors[:name], "can't be blank"
  end

  test "administered_at is required" do
    treatment = build_treatment(administered_at: nil)

    assert_not treatment.valid?
    assert_includes treatment.errors[:administered_at], "can't be blank"
  end

  test "appointment is required" do
    treatment = build_treatment(appointment: nil)

    assert_not treatment.valid?
    assert_includes treatment.errors[:appointment], "can't be blank"
  end

  private

  def build_treatment(attributes = {})
    defaults = {
      appointment: create_appointment,
      name: "Treatment",
      medication: "Med",
      dosage: "1 daily",
      notes: "none",
      administered_at: Time.current
    }

    Treatment.new(defaults.merge(attributes))
  end

  def create_owner
    Owner.create!(
      first_name: "Treatment",
      last_name: "Owner",
      email: "treatment_owner_#{SecureRandom.hex(4)}@example.com",
      phone: "777777777"
    )
  end

  def create_pet
    Pet.create!(
      name: "Pet Name",
      species: "cat",
      breed: "Mix",
      date_of_birth: Date.new(2020, 1, 1),
      weight: 7,
      owner: create_owner
    )
  end

  def create_vet
    Vet.create!(
      first_name: "Victor",
      last_name: "Vet",
      email: "treatment_vet_#{SecureRandom.hex(4)}@example.com",
      phone: "888999000",
      specialization: "General"
    )
  end

  def create_appointment
    Appointment.create!(
      pet: create_pet,
      vet: create_vet,
      date: Time.current + 1.hour,
      reason: "Checkup",
      status: :scheduled
    )
  end
end
