require 'test_helper'

class Api::V1::EndcompetitionsControllerTest < ActionDispatch::IntegrationTest

	competition_url = '/api/v1/endcompetitions'

	test "Competition end" do

		get competition_url
		assert_response :success
		body = JSON.parse(@response.body)
		competition = body['data'].first

		post competition_url, params: { id:competition['id'] } 
		assert_response :success

		body = JSON.parse(@response.body)
		competition = body['data']
		assert_equal competition['encerrada'], true
		assert competition['fim'] != nil

	end

	test "Validate end competition" do
		
		assert_raises(ActiveRecord::RecordNotFound) do
			post competition_url, params: { id:978 } 
	    end

	end
	

end
