require 'test_helper'

class InitiativesControllerTest < ActionController::TestCase
  setup do
    @initiative = initiatives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:initiatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create initiative" do
    assert_difference('Initiative.count') do
      post :create, initiative: { alternatives: @initiative.alternatives, cost_analysis: @initiative.cost_analysis, description: @initiative.description, justification: @initiative.justification, lead_agency: @initiative.lead_agency, sec_agency_1: @initiative.sec_agency_1, sec_agency_2: @initiative.sec_agency_2, title: @initiative.title }
    end

    assert_redirected_to initiative_path(assigns(:initiative))
  end

  test "should show initiative" do
    get :show, id: @initiative
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @initiative
    assert_response :success
  end

  test "should update initiative" do
    patch :update, id: @initiative, initiative: { alternatives: @initiative.alternatives, cost_analysis: @initiative.cost_analysis, description: @initiative.description, justification: @initiative.justification, lead_agency: @initiative.lead_agency, sec_agency_1: @initiative.sec_agency_1, sec_agency_2: @initiative.sec_agency_2, title: @initiative.title }
    assert_redirected_to initiative_path(assigns(:initiative))
  end

  test "should destroy initiative" do
    assert_difference('Initiative.count', -1) do
      delete :destroy, id: @initiative
    end

    assert_redirected_to initiatives_path
  end
end
