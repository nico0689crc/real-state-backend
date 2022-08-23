require "test_helper"

class JobsApplicantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jobs_applicant = jobs_applicants(:one)
  end

  test "should get index" do
    get jobs_applicants_url, as: :json
    assert_response :success
  end

  test "should create jobs_applicant" do
    assert_difference("JobsApplicant.count") do
      post jobs_applicants_url, params: { jobs_applicant: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show jobs_applicant" do
    get jobs_applicant_url(@jobs_applicant), as: :json
    assert_response :success
  end

  test "should update jobs_applicant" do
    patch jobs_applicant_url(@jobs_applicant), params: { jobs_applicant: {  } }, as: :json
    assert_response :success
  end

  test "should destroy jobs_applicant" do
    assert_difference("JobsApplicant.count", -1) do
      delete jobs_applicant_url(@jobs_applicant), as: :json
    end

    assert_response :no_content
  end
end
