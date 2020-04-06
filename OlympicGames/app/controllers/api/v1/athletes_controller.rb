class Api::V1::AthletesController < ApplicationController
	def index
		athletes = Athlete.order('created_at DESC');
		render json: {status: 'SUCCESS', message:'Artigos carregados', data:athletes},status: :ok
	end
	def show
		athlete = Athlete.find(params[:id])
		render json: {status: 'SUCCESS', message:'Loaded athlete', data:athlete},status: :ok
	end
	def create
		athlete = Athlete.new(athlete_params)
		if athlete.save
			render json: {status: 'SUCCESS', message:'Atleta criado com sucesso', data:athlete},status: :ok
		else
			render json: {status: 'ERROR', message:'invalid paramters', data:athlete.errors},status: :unprocessable_entity
		end
	end

	private
	def athlete_params
		params.require(:athlete).permit(:nome)
	end	
end
