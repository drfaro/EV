class Api::V1::ResultsController < ApplicationController
	def index
		competitions = Competition.order('created_at DESC');
		render json: {status: 'SUCCESS', message:'Listar Competições', data:competitions},status: :ok
	end
	def show
		message = 'Ranking fechado'
		winners = []
		competition = Competition.find(params[:id])
		if competition != nil
			
			if !competition.encerrada
				message = 'Ranking parcial'
			end
			
			message = competition.nome+" - "+message
			winners = Match.where(competition_id:competition.id).order('value '+competition.ordenacao).limit(3)
			
			if winners.length >= 1
				render json: {status: 'SUCCESS', message:message, data:winners},status: :ok
			else
				render json: {status: 'SUCCESS', message:competition.nome+' - A competição ainda não possui resultados', data:""},status: :ok
			end
			
		else
			render json: {status: 'Error', message:'Competição não encontrada', data:""},status: :ok
		end
	end

	private
	def competitions_params
		params.permit(:nome, :tem_limite, :limite)
	end

end
