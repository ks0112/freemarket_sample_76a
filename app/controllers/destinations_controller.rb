class DestinationsController < ApplicationController
  def index
  end
  def new
    destination = Destination.find_by(user_id: current_user.id)
    unless destination.blank?
      redirect_to edit_destination_path(destination.id)
    else
    　@destination = Destination.new
    end
  end
  # def new
  #   destination = Destination.where(user_id: current_user.id)
  #   redirect_to edit_destination_path(current_user.id) if destination.exists?
  #   @destination = Destination.new
  # end

  def create
    @destination = Destination.create(destination_params)
    redirect_back(fallback_location: root_path)
  end

  def edit
    @destination = Destination.find_by(user_id: current_user.id)
    if @destination.blank?
      redirect_to new_destination_path
    end
  end

  def update
    @destination = Destination.find(params[:id])
    @destination.update(destination_params)
    redirect_to edit_destination_path(current_user.id)
  end

  def show
  end

  private
  def destination_params
    params.require(:destination).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id)
  end

end
