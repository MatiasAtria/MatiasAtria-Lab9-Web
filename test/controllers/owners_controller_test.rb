require "test_helper"

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:one)
  end

  test "should get index" do
    get owners_url
    assert_response :success
  end

  test "should get show" do
    get owner_url(@owner)
    assert_response :success
  end

  test "should get new" do
    get new_owner_url
    assert_response :success
  end

  test "should create owner with valid params" do
    assert_difference("Owner.count") do
      post owners_url, params: { owner: {
        first_name: "Pedro", last_name: "Gonzalez",
        email: "pedro@test.com", phone: "111222333", address: "Calle 1"
      } }
    end
    assert_redirected_to owner_url(Owner.last)
    assert_equal "Owner created successfully.", flash[:notice]
  end

  test "should not create owner with invalid params" do
    post owners_url, params: { owner: { first_name: "", email: "bad" } }
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_owner_url(@owner)
    assert_response :success
  end

  test "should update owner with valid params" do
    patch owner_url(@owner), params: { owner: { first_name: "Updated" } }
    assert_redirected_to owner_url(@owner)
    assert_equal "Owner updated successfully.", flash[:notice]
  end

  test "should destroy owner" do
    assert_difference("Owner.count", -1) do
      delete owner_url(@owner)
    end
    assert_redirected_to owners_url
    assert_equal "Owner deleted successfully.", flash[:notice]
  end
end