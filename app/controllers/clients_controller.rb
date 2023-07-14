class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        clients = Client.all
        render json: clients
    end

    def show
        client = Client.find(params[:id])
        total_amount = client.memberships.sum(:charge)
        render json: { client: client, total_amount: total_amount }, status: :ok
    end

    def update
        client = Client.find(params[:id])
        client.update(client_params)
        render json: client
    end

    private
    def client_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Client not found" }, status: :not_found
    end
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
