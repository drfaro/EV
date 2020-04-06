require 'test_helper'

class Api::V1::AthletesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

	test "create an athletes" do
	  post "/api/v1/athletes"
	  assert_response :success
	  
	  #post "/athletes",
	  #  params: { athletes: { nome: "Nome test 1"} }
	
	  #assert_select "nome", "Nome test 1"
	end


end
