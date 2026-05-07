require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get appointments_url
    assert_response :success
  end

  test "should get show" do
    get appointment_url(@appointment)
    assert_response :success
  end

  test "should get new" do
    get new_appointment_url
    assert_response :success
  end

  test "should create appointment with valid params" do
    assert_difference("Appointment.count") do
      post appointments_url, params: { appointment: {
        date: "2026-06-01 10:00:00",
        reason: "Annual checkup",
        status: "scheduled",
        pet_id: pets(:one).id,
        vet_id: vets(:one).id
      } }
    end
    assert_redirected_to appointment_url(Appointment.last)
    assert_equal "Appointment created successfully.", flash[:notice]
  end

  test "should not create appointment with invalid params" do
    post appointments_url, params: { appointment: { reason: "" } }
    assert_response :unprocessable_entity
  end

  test "should update appointment with valid params" do
    patch appointment_url(@appointment), params: { appointment: { reason: "Updated reason" } }
    assert_redirected_to appointment_url(@appointment)
  end

  test "should destroy appointment" do
    assert_difference("Appointment.count", -1) do
      delete appointment_url(@appointment)
    end
    assert_redirected_to appointments_url
    assert_equal "Appointment deleted successfully.", flash[:notice]
  end
end