class DestinationsController < ApplicationController
  def index
  end

  def show
    @destination = Destination.find(params[:id])
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    destination.update(post_params)
    redirect_to destinations_path
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.create(post_params)
    redirect_to destinations_path
  end

  private
  def destination_params
    params.require(:destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :prefecture, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id)
  end

end
