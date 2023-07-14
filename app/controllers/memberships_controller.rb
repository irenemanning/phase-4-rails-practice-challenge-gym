class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # def create
    #     membership = Membership.create(membership_params)
    #     byebug
    #     render json: membership, status: :created
    # end
    
    #Handle the custom validation error
    def create
        membership = Membership.new(membership_params)
    
        if membership.save
          render json: membership, status: :created
        else
          render json: { errors: membership.errors.full_messages }, status: :unprocessable_entity
        end
      end
    private 
    def membership_params
        params.permit(:gym_id, :client_id, :charge)
    end
    def render_not_found_response
        render json: { error: "Membership not found" }, status: :not_found
    end
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
