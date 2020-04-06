require 'test_helper'

class Api::V1::ResultsControllerTest < ActionDispatch::IntegrationTest
  
	$competition_url = '/api/v1/competitions'
	$startcompetition_url = '/api/v1/startcompetitions'
	$endcompetition_url = '/api/v1/endcompetitions'
	$athlete_url = '/api/v1/athletes'
	$match_url = '/api/v1/matchs'
	$result_url = '/api/v1/results'

	test "validate results DESC" do
		
		competition = createCompetitionLimited("DESC")
		
		startCompetition(competition)

		athlete1 = createAthlete("athlete1")
		athlete2 = createAthlete("athlete2")
		athlete3 = createAthlete("athlete3")		

		createMacth(competition, athlete1, "1.0")
		createMacth(competition, athlete2, "2.0")
		createMacth(competition, athlete3, "3.0")

		results = getResult(competition['id'])

		assert_equal results[0]['competition_id'], competition['id']
		assert_equal results[0]['athlete_id'], athlete3['id']
		assert_equal results[0]['atleta'], athlete3['nome']
		assert_equal results[0]['competicao'], competition['nome']
		assert_equal results[0]['value'], "3.0"

		assert_equal results[1]['competition_id'], competition['id']
		assert_equal results[1]['athlete_id'], athlete2['id']
		assert_equal results[1]['atleta'], athlete2['nome']
		assert_equal results[1]['competicao'], competition['nome']
		assert_equal results[1]['value'], "2.0"

		assert_equal results[2]['competition_id'], competition['id']
		assert_equal results[2]['athlete_id'], athlete1['id']
		assert_equal results[2]['atleta'], athlete1['nome']
		assert_equal results[2]['competicao'], competition['nome']
		assert_equal results[2]['value'], "1.0"

	end

	test "validate results ASC" do
		
		competition = createCompetitionLimited("ASC")
		
		startCompetition(competition)

		athlete1 = createAthlete("athlete1")
		athlete2 = createAthlete("athlete2")
		athlete3 = createAthlete("athlete3")		

		createMacth(competition, athlete1, "1.0")
		createMacth(competition, athlete2, "2.0")
		createMacth(competition, athlete3, "3.0")

		results = getResult(competition['id'])

		assert_equal results[2]['competition_id'], competition['id']
		assert_equal results[2]['athlete_id'], athlete3['id']
		assert_equal results[2]['atleta'], athlete3['nome']
		assert_equal results[2]['competicao'], competition['nome']
		assert_equal results[2]['value'], "3.0"

		assert_equal results[1]['competition_id'], competition['id']
		assert_equal results[1]['athlete_id'], athlete2['id']
		assert_equal results[1]['atleta'], athlete2['nome']
		assert_equal results[1]['competicao'], competition['nome']
		assert_equal results[1]['value'], "2.0"

		assert_equal results[0]['competition_id'], competition['id']
		assert_equal results[0]['athlete_id'], athlete1['id']
		assert_equal results[0]['atleta'], athlete1['nome']
		assert_equal results[0]['competicao'], competition['nome']
		assert_equal results[0]['value'], "1.0"

	end

	test "404 competition RecordNotFound" do
		assert_raises(ActiveRecord::RecordNotFound) do
			getResult(999)
	    end
	end

	def getResult competition_id
		get $result_url+"/"+competition_id.to_s
		assert_response :success
		body = JSON.parse(@response.body)
		results = body['data']
		assert results != nil
		results
	end

	def createCompetitionLimited ordenacao
		post $competition_url, params: {nome:"arco", tem_limite: true, limite: 3, ordenacao: ordenacao} 
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

	def createAthlete nome
		post $athlete_url, params: {athlete: {nome:nome}}
		assert_response :success
		body = JSON.parse(@response.body)
		athlete = body['data']
		assert athlete != nil
		athlete
	end


	def createMacth competition, athlete, value
		post $match_url, params: { competicao: competition['nome'], atleta: athlete['nome'],value: value, unidade: "m"} 
		assert_response :success
		body = JSON.parse(@response.body)
		assert_equal body['message'], "A partida foi salva com sucesso"
	end


end
