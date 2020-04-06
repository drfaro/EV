require 'test_helper'
require "json"

class Api::V1::AthletesControllerTest < ActionDispatch::IntegrationTest

	athlete_url = '/api/v1/athletes'

	test "create athlete" do

		get athlete_url
		assert_response :success
		body = JSON.parse(@response.body)
		total_athletes = body['data'].length
		total_athletes += 1

		post athlete_url, params: { athlete: { nome: 'Some title' } }
		assert_response :success

		get athlete_url
		body = JSON.parse(@response.body)
		assert_equal total_athletes, body['data'].length

	end

	test "validate create athletes" do
		
		get athlete_url
		post athlete_url, params: { athlete: { name: 'Some title' } }
		body = JSON.parse(@response.body)
		assert_equal body['status'], "ERROR"
		assert_equal body['message'], "Parametros invalidos"

	end

	test "try dupicate athlete" do
		
		get athlete_url
		assert_response :success
		body = JSON.parse(@response.body)
		athlete = body['data'].first
		
		post athlete_url, params: { nome: athlete['nome'] }
		assert_response :success

		body = JSON.parse(@response.body)
		assert_equal body['message'], "O atleta ja era cadastrado"

	end

end