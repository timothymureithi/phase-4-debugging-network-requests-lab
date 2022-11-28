class ToysController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_toy_not_found
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys, status: :ok
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find(params[:id])
    toy.update(toy_params)
    render json: toy, status: :ok
  end


  def destroy
    toy = Toy.find(params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_toy_not_found
		render json: {error: "Toy not found!"}, status: :not_found
	end

end