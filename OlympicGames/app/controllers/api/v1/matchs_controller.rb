class Api::V1::MatchsController < ApplicationController

	def create
		validate_limite = true
		match = []
		competitions = Competition.where(nome:params[:competicao]).limit(1)
		athletes = Athlete.where(nome:params[:atleta]).limit(1)

		if competitions.length > 0 
	
			competition = competitions.first
			
			if !competition.encerrada

			 	if (athletes.length > 0)
					athlete = athletes.first
				else
					athlete = Athlete.new(nome:params[:atleta])
					athlete.save
				end 

				if (athlete != nil)

					if competition.tem_limite
						match = Match.where(athlete_id:athlete.id, competition_id:competition.id)
						if match.length >= competition.limite
							validate_limite = false
						end
					end

					if (validate_limite)

						params[:competition_id] = competition.id
						params[:athlete_id] = athlete.id

						match = Match.new(match_params)
						if match.save
							render json: {status: 'SUCCESS', message:'A partida foi salva com sucesso', data:{competition:competition, athlete:athlete}},status: :ok							
						else
							render json: {status: 'ERROR', message:"Ocorreu um erro ao salvar a partida ", data:{errors:match.errors, competition: competition.id, athlete:athlete.id }},status: :ok
						end

					else
						render json: {status: 'ERROR', message:"O atleta "+athlete.nome+" ja competiu o numero maximo de ("+competition.limite.to_s+"x) vezes.", data:match},status: :ok
					end
				else
					render json: {status: 'ERROR', message:"O atleta não esta cadastrado", data: params},status: :ok
				end
			else
				render json: {status: 'ERROR', message:"A competicao foi encerrada " + (competition.fim != nil ? competition.fim.strftime("as %I:%M%p"):"" ) , data:competition},status: :ok
			end
		else
			render json: {status: 'ERROR', message:'Competição não encontrada', data:params},status: :unprocessable_entity
		end
	end
	private
	def match_params
		params.permit(:competicao, :atleta, :value, :unidade, :competition_id, :athlete_id)
	end	

end