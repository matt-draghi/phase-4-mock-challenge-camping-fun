class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        activities = Activity.all
        render json: activities, status: 200
    end

    def destroy
        activity = Activity.find(params[:id])
        activity.destroy

        render json: {}
    end

    private 

    def render_not_found_response
        render json: {error: "Activity not found"}, status: :not_found
    end
end
