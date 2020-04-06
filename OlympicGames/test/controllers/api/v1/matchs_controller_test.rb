require 'test_helper'

class Api::V1::MatchsControllerTest < ActionDispatch::IntegrationTest
  
	$competition_url = '/api/v1/competitions'
	$startcompetition_url = '/api/v1/startcompetitions'
	$endcompetition_url = '/api/v1/endcompetitions'
	$athlete_url = '/api/v1/athletes'
	$match_url = '/api/v1/matchs'

	test "create matchs" do
		
		competition = getCompetition()
		
		startCompetition(competition)

		athlete = getAthlete()

		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: "8.232", unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		assert_equal body['message'], "A partida foi salva com sucesso"
		
	end

	test "create matchs after end competition" do
		
		competition = getCompetition()
		
		startCompetition(competition)

		athlete = getAthlete()

		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: "8.232", unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		assert_equal body['message'], "A partida foi salva com sucesso"

		endCompetition(competition)

		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: "8.232", unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		
		assert body['message'].include? "encerrada"

		
	end

	test "limit matchs" do
		
		competition = createCompetitionLimited()
		
		startCompetition(competition)

		athlete = getAthlete()

		createMacths(competition, athlete)

		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: "3.1", unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		assert body['message'].include? "maximo"
		
	end

	def getCompetition
		get $startcompetition_url
		assert_response :success
		body = JSON.parse(@response.body)
		competition = body['data'].first
		assert competition != nil
		competition
	end

	def createCompetitionLimited
		post $competition_url, params: {nome:"arco", tem_limite: true, limite: 3, ordenacao: "DESC"} 
		assert_response :success
		body = JSON.parse(@response.body)
		competition = body['data']
		assert competition != nil
		competition
	end

	def startCompetition competition
		post $startcompetition_url, params: { id:competition['id'] } 
		assert_response :success
		body = JSON.parse(@response.body)
		competition = body['data']
		assert_equal competition['encerrada'], false
		assert competition['inicio'] != nil
	end

	def endCompetition competition
		post $endcompetition_url, params: { id:competition['id'] } 
		assert_response :success
		body = JSON.parse(@response.body)
		competition = body['data']
		assert_equal competition['encerrada'], true
		assert competition['fim'] != nil
	end

	def getAthlete
		get $athlete_url
		assert_response :success
		body = JSON.parse(@response.body)
		athlete = body['data'].first
		assert athlete != nil
		athlete
	end


	def createMacths competition, athlete

		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: "1.4", unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		assert_equal body['message'], "A partida foi salva com sucesso"
		
		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: "2.3", unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		assert_equal body['message'], "A partida foi salva com sucesso"
		
		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: "3.2", unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		assert_equal body['message'], "A partida foi salva com sucesso"

	end


end
