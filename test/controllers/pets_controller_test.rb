require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pet = pets(:one)
  end

  test "should get index" do
    get pets_url
    assert_response :success
  end

  test "should get show" do
    get pet_url(@pet)
    assert_response :success
  end

  test "should get new" do
    get new_pet_url
    assert_response :success
  end

  test "should create pet with valid params" do
    assert_difference("Pet.count") do
      post pets_url, params: { pet: {
        name: "Max", species: "dog", breed: "Beagle",
        date_of_birth: "2022-01-01", weight: 10.5,
        owner_id: owners(:one).id
      } }
    end
    assert_redirected_to pet_url(Pet.last)
    assert_equal "Pet created successfully.", flash[:notice]
  end

  test "should not create pet with invalid params" do
    post pets_url, params: { pet: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should update pet with valid params" do
    patch pet_url(@pet), params: { pet: { name: "Rocky Updated" } }
    assert_redirected_to pet_url(@pet)
  end

  test "should destroy pet" do
    assert_difference("Pet.count", -1) do
      delete pet_url(@pet)
    end
    assert_redirected_to pets_url
    assert_equal "Pet deleted successfully.", flash[:notice]
  end
end