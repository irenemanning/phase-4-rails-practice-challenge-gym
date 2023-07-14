class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        gym = Gym.all
        render json: gym
    end
    def show
        gym = Gym.find_by(params[:id])
        render json: gym
    end
    def update
        gym = Gym.find_by(params[:id])
        gym.update(gym_params)
        render json: gym
    end
    def destroy
        gym = Gym.find_by(params[:id])
        head :no_content
    end

    private
    def gym_params
        params.permit(:name, :address)
    end

    def render_not_found_response
        render json: { error: "Gym not found" }, status: :not_found
    end
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
