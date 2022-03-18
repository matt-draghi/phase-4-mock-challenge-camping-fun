class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        campers = Camper.all
        render json: campers, status: 200
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, include: :activities, status: 200
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: 201
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    private

    def render_not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

end
