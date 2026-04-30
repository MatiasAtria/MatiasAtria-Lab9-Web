require "test_helper"

class VetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vet = vets(:one)
  end

  test "should get index" do
    get vets_url
    assert_response :success
  end

  test "should get show" do
    get vet_url(@vet)
    assert_response :success
  end

  test "should get new" do
    get new_vet_url
    assert_response :success
  end

  test "should create vet with valid params" do
    assert_difference("Vet.count") do
      post vets_url, params: { vet: {
        first_name: "Luis", last_name: "Herrera",
        email: "luis@vet.com", phone: "999888777",
        specialization: "Cardiology"
      } }
    end
    assert_redirected_to vet_url(Vet.last)
    assert_equal "Vet created successfully.", flash[:notice]
  end

  test "should not create vet with invalid params" do
    post vets_url, params: { vet: { first_name: "" } }
    assert_response :unprocessable_entity
  end

  test "should update vet with valid params" do
    patch vet_url(@vet), params: { vet: { specialization: "Neurology" } }
    assert_redirected_to vet_url(@vet)
  end

  test "should destroy vet" do
    assert_difference("Vet.count", -1) do
      delete vet_url(@vet)
    end
    assert_redirected_to vets_url
    assert_equal "Vet deleted successfully.", flash[:notice]
  end
end