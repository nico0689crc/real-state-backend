require "test_helper"

class AttendantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attendant = attendants(:one)
  end

  test "should get index" do
    get attendants_url, as: :json
    assert_response :success
  end

  test "should create attendant" do
    assert_difference("Attendant.count") do
      post attendants_url, params: { attendant: { company_name: @attendant.company_name, contact_email: @attendant.contact_email, contact_linked_in: @attendant.contact_linked_in, contact_whatsapp: @attendant.contact_whatsapp, first_name: @attendant.first_name, last_name: @attendant.last_name } }, as: :json
    end

    assert_response :created
  end

  test "should show attendant" do
    get attendant_url(@attendant), as: :json
    assert_response :success
  end

  test "should update attendant" do
    patch attendant_url(@attendant), params: { attendant: { company_name: @attendant.company_name, contact_email: @attendant.contact_email, contact_linked_in: @attendant.contact_linked_in, contact_whatsapp: @attendant.contact_whatsapp, first_name: @attendant.first_name, last_name: @attendant.last_name } }, as: :json
    assert_response :success
  end

  test "should destroy attendant" do
    assert_difference("Attendant.count", -1) do
      delete attendant_url(@attendant), as: :json
    end

    assert_response :no_content
  end
end
