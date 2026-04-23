require "test_helper"

class VetTest < ActiveSupport::TestCase
  test "valid vet can be saved" do
    vet = build_vet

    assert vet.save
  end

  test "first_name is required" do
    vet = build_vet(first_name: nil)

    assert_not vet.valid?
    assert_includes vet.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    vet = build_vet(last_name: nil)

    assert_not vet.valid?
    assert_includes vet.errors[:last_name], "can't be blank"
  end

  test "email is required" do
    vet = build_vet(email: nil)

    assert_not vet.valid?
    assert_includes vet.errors[:email], "can't be blank"
  end

  test "email must have valid format" do
    vet = build_vet(email: "invalid")

    assert_not vet.valid?
    assert_includes vet.errors[:email], "is invalid"
  end

  test "email must be unique" do
    existing = build_vet(email: "vet@example.com")
    assert existing.save

    duplicate = build_vet(email: "VET@example.com")

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "specialization is required" do
    vet = build_vet(specialization: nil)

    assert_not vet.valid?
    assert_includes vet.errors[:specialization], "can't be blank"
  end

  test "email is normalized before validation" do
    vet = build_vet(email: "  VetMixed@Example.COM  ")

    vet.valid?

    assert_equal "vetmixed@example.com", vet.email
  end

  private

  def build_vet(attributes = {})
    defaults = {
      first_name: "Ana",
      last_name: "Smith",
      email: "vet_#{SecureRandom.hex(4)}@example.com",
      phone: "123123123",
      specialization: "General"
    }

    Vet.new(defaults.merge(attributes))
  end
end
