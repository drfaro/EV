class Api::V1::CompetitionsController < ApplicationController
	def index
		competitions = Competition.order('created_at DESC');
		render json: {status: 'SUCCESS', message:'Listar Competições', data:competitions},status: :ok
	end
	
	def create
		competition = Competition.new(competitions_params)
		
		if (competition.tem_limite == nil)
			competition.tem_limite = false
			competition.limite = 0
		end
		
		if competition.save
			render json: {status: 'SUCCESS', message:'Competição criada com sucesso', data:competition},status: :ok
		else
			render json: {status: 'ERROR', message:'error', data:competition.errors},status: :unprocessable_entity
		end
	end

	private
	def competitions_params
		params.permit(:nome, :tem_limite, :limite)
	end

end
