class Api::V1::AthletesController < ApplicationController
	def index
		athletes = Athlete.order('created_at DESC');
		render json: {status: 'SUCCESS', message:'Lista de atletas', data:athletes},status: :ok
	end
	def show
		athlete = Athlete.find(params[:id])
		render json: {status: 'SUCCESS', message:'Loaded athlete', data:athlete},status: :ok
	end
	def create
		athletes = Athlete.where(nome:params[:nome]).limit(1)
		if athletes.length == 0
			athlete = Athlete.new(athlete_params)
			if athlete.save
				render json: {status: 'SUCCESS', message:'Atleta criado com sucesso', data:athlete},status: :ok
			else
				render json: {status: 'ERROR', message:'Parametros invalidos', data:athlete.errors},status: :unprocessable_entity
			end
		else
			athlete = athletes.first
			render json: {status: 'SUCCESS', message:'O atleta ja era cadastrado', data:athlete},status: :ok
		end
	end

	private
	def athlete_params
		params.require(:athlete).permit(:nome)
	end	
end
