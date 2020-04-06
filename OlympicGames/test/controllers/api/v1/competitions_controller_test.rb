require 'test_helper'

class Api::V1::CompetitionControllerTest < ActionDispatch::IntegrationTest

	competition_url = '/api/v1/competitions'

	test "create competition" do
		
		get competition_url
		assert_response :success
		body = JSON.parse(@response.body)
		total_competition = body['data'].length
		total_competition += 1

		post competition_url, params: { nome: "competicao 3 Dardo", tem_limite: true, limite: 3, ordenacao: "DESC" } 
		assert_response :success

		get competition_url
		body = JSON.parse(@response.body)
		assert_equal total_competition, body['data'].length

	end

	test "validate create competition" do
		
		get competition_url
		post competition_url, params: { name: 'Some title' }
		body = JSON.parse(@response.body)
		assert_equal body['status'], "ERROR"
		assert_equal body['message'], "Parametros invalidos"

	end
	

end
