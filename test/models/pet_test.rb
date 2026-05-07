require "test_helper"

class PetTest < ActiveSupport::TestCase
  test "valid pet can be saved" do
    pet = build_pet

    assert pet.save
  end

  test "name is required" do
    pet = build_pet(name: nil)

    assert_not pet.valid?
    assert_includes pet.errors[:name], "can't be blank"
  end

  test "species is required" do
    pet = build_pet(species: nil)

    assert_not pet.valid?
    assert_includes pet.errors[:species], "can't be blank"
  end

  test "species must be in allowed list" do
    pet = build_pet(species: "horse")

    assert_not pet.valid?
    assert_includes pet.errors[:species], "is not included in the list"
  end

  test "date_of_birth is required" do
    pet = build_pet(date_of_birth: nil)

    assert_not pet.valid?
    assert_includes pet.errors[:date_of_birth], "can't be blank"
  end

  test "date_of_birth cannot be in the future" do
    pet = build_pet(date_of_birth: Date.current + 1.day)

    assert_not pet.valid?
    assert_includes pet.errors[:date_of_birth], "can't be in the future"
  end

  test "weight is required" do
    pet = build_pet(weight: nil)

    assert_not pet.valid?
    assert_includes pet.errors[:weight], "can't be blank"
  end

  test "weight must be greater than 0" do
    pet = build_pet(weight: 0)

    assert_not pet.valid?
    assert_includes pet.errors[:weight], "must be greater than 0"
  end

  test "owner is required" do
    pet = build_pet(owner: nil)

    assert_not pet.valid?
    assert_includes pet.errors[:owner], "can't be blank"
  end

  test "name is capitalized before save" do
    pet = build_pet(name: "  judy hopps ")

    assert pet.save
    assert_equal "Judy Hopps", pet.name
  end

  private

  def build_pet(attributes = {})
    defaults = {
      name: "Niki",
      species: "dog",
      breed: "Mix",
      date_of_birth: Date.new(2020, 1, 1),
      weight: 8.5,
      owner: create_owner
    }

    Pet.new(defaults.merge(attributes))
  end

  def create_owner
    Owner.create!(
      first_name: "Pet",
      last_name: "Owner",
      email: "pet_owner_#{SecureRandom.hex(4)}@example.com",
      phone: "999888777"
    )
  end
end
