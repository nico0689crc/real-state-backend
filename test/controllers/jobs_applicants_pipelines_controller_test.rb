require "test_helper"

class JobsApplicantsPipelinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jobs_applicants_pipeline = jobs_applicants_pipelines(:one)
  end

  test "should get index" do
    get jobs_applicants_pipelines_url, as: :json
    assert_response :success
  end

  test "should create jobs_applicants_pipeline" do
    assert_difference("JobsApplicantsPipeline.count") do
      post jobs_applicants_pipelines_url, params: { jobs_applicants_pipeline: { jobs_applicant_id: @jobs_applicants_pipeline.jobs_applicant_id, passed: @jobs_applicants_pipeline.passed, pipeline_id: @jobs_applicants_pipeline.pipeline_id } }, as: :json
    end

    assert_response :created
  end

  test "should show jobs_applicants_pipeline" do
    get jobs_applicants_pipeline_url(@jobs_applicants_pipeline), as: :json
    assert_response :success
  end

  test "should update jobs_applicants_pipeline" do
    patch jobs_applicants_pipeline_url(@jobs_applicants_pipeline), params: { jobs_applicants_pipeline: { jobs_applicant_id: @jobs_applicants_pipeline.jobs_applicant_id, passed: @jobs_applicants_pipeline.passed, pipeline_id: @jobs_applicants_pipeline.pipeline_id } }, as: :json
    assert_response :success
  end

  test "should destroy jobs_applicants_pipeline" do
    assert_difference("JobsApplicantsPipeline.count", -1) do
      delete jobs_applicants_pipeline_url(@jobs_applicants_pipeline), as: :json
    end

    assert_response :no_content
  end
end
