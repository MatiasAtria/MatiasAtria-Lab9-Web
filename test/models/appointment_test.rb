require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  test "valid appointment can be saved" do
    appointment = build_appointment

    assert appointment.save
  end

  test "date is required" do
    appointment = build_appointment(date: nil)

    assert_not appointment.valid?
    assert_includes appointment.errors[:date], "can't be blank"
  end

  test "reason is required" do
    appointment = build_appointment(reason: nil)

    assert_not appointment.valid?
    assert_includes appointment.errors[:reason], "can't be blank"
  end

  test "pet is required" do
    appointment = build_appointment(pet: nil)

    assert_not appointment.valid?
    assert_includes appointment.errors[:pet], "can't be blank"
  end

  test "vet is required" do
    appointment = build_appointment(vet: nil)

    assert_not appointment.valid?
    assert_includes appointment.errors[:vet], "can't be blank"
  end

  test "status is required" do
    appointment = build_appointment(status: nil)

    assert_not appointment.valid?
    assert_includes appointment.errors[:status], "can't be blank"
  end

  private

  def build_appointment(attributes = {})
    defaults = {
      pet: create_pet,
      vet: create_vet,
      date: Time.current + 1.day,
      reason: "Checkup",
      status: :scheduled
    }

    Appointment.new(defaults.merge(attributes))
  end

  def create_owner
    Owner.create!(
      first_name: "Appointment",
      last_name: "Owner",
      email: "appointment_owner_#{SecureRandom.hex(4)}@example.com",
      phone: "555555555"
    )
  end

  def create_pet
    Pet.create!(
      name: "Pet Name",
      species: "dog",
      breed: "Mix",
      date_of_birth: Date.new(2021, 1, 1),
      weight: 10,
      owner: create_owner
    )
  end

  def create_vet
    Vet.create!(
      first_name: "Maria",
      last_name: "Vet",
      email: "appointment_vet_#{SecureRandom.hex(4)}@example.com",
      phone: "222333444",
      specialization: "General"
    )
  end
end
