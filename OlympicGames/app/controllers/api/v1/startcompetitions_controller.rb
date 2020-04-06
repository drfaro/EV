class Api::V1::StartcompetitionsController < ApplicationController
	def index
		competitions = Competition.order('created_at DESC');
		render json: {status: 'SUCCESS', message:'Lista de competicoes', data:competitions},status: :ok
	end
	def show
		validate_and_update(params[:id])
	end

	def create
		validate_and_update(competitions_params)
	end

	private
	def validate_and_update(param_id)
		if param_id
			competition = Competition.find(param_id)
			if competition.update_attributes({inicio:DateTime.now, encerrada:false})
				render json: {status: 'SUCCESS', message:'Competição iniciada', data:competition},status: :ok
			else
				render json: {status: 'ERROR', message:'Ocorreu um erro iniciar competição', data:competition.errors},status: :unprocessable_entity
			end
		else
			render json: {status: 'ERROR', message:'Parametros invalidos', data:params},status: :unprocessable_entity
		end
	end	

	private
	def competitions_params
		params.require(:id)
	end	
end
