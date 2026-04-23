require "test_helper"

class OwnerTest < ActiveSupport::TestCase
  test "valid owner can be saved" do
    owner = build_owner

    assert owner.save
  end

  test "first_name is required" do
    owner = build_owner(first_name: nil)

    assert_not owner.valid?
    assert_includes owner.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    owner = build_owner(last_name: nil)

    assert_not owner.valid?
    assert_includes owner.errors[:last_name], "can't be blank"
  end

  test "email is required" do
    owner = build_owner(email: nil)

    assert_not owner.valid?
    assert_includes owner.errors[:email], "can't be blank"
  end

  test "email must have valid format" do
    owner = build_owner(email: "invalid-email")

    assert_not owner.valid?
    assert_includes owner.errors[:email], "is invalid"
  end

  test "email must be unique" do
    existing = build_owner(email: "owner@example.com")
    assert existing.save

    duplicate = build_owner(email: "OWNER@example.com")

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "phone is required" do
    owner = build_owner(phone: nil)

    assert_not owner.valid?
    assert_includes owner.errors[:phone], "can't be blank"
  end

  test "email is normalized before validation" do
    owner = build_owner(email: "  MixedCase@Email.COM  ")

    owner.valid?

    assert_equal "mixedcase@email.com", owner.email
  end

  private

  def build_owner(attributes = {})
    defaults = {
      first_name: "John",
      last_name: "Doe",
      email: "owner_#{SecureRandom.hex(4)}@example.com",
      phone: "1234567890",
      address: "123 Main St"
    }

    Owner.new(defaults.merge(attributes))
  end
end
