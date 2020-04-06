require 'test_helper'

class Api::V1::StartcompetitionsControllerTest < ActionDispatch::IntegrationTest

	startcompetition_url = '/api/v1/startcompetitions'

	test "Competition Start" do

		get startcompetition_url
		assert_response :success
		body = JSON.parse(@response.body)
		competition = body['data'].first

		post startcompetition_url, params: { id:competition['id'] } 
		assert_response :success

		body = JSON.parse(@response.body)
		competition = body['data']
		assert_equal competition['encerrada'], false
		assert competition['inicio'] != nil

	end

	test "start competition 404" do
		assert_raises(ActiveRecord::RecordNotFound) do
			post startcompetition_url, params: { id:978 } 
	    end
	end
end
