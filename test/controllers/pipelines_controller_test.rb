require "test_helper"

class PipelinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pipeline = pipelines(:one)
  end

  test "should get index" do
    get pipelines_url, as: :json
    assert_response :success
  end

  test "should create pipeline" do
    assert_difference("Pipeline.count") do
      post pipelines_url, params: { pipeline: { attendant_id: @pipeline.attendant_id, description: @pipeline.description, job_id: @pipeline.job_id, order: @pipeline.order, title: @pipeline.title } }, as: :json
    end

    assert_response :created
  end

  test "should show pipeline" do
    get pipeline_url(@pipeline), as: :json
    assert_response :success
  end

  test "should update pipeline" do
    patch pipeline_url(@pipeline), params: { pipeline: { attendant_id: @pipeline.attendant_id, description: @pipeline.description, job_id: @pipeline.job_id, order: @pipeline.order, title: @pipeline.title } }, as: :json
    assert_response :success
  end

  test "should destroy pipeline" do
    assert_difference("Pipeline.count", -1) do
      delete pipeline_url(@pipeline), as: :json
    end

    assert_response :no_content
  end
end
