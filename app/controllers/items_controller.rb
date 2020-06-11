class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @item = Item.new(item_params)
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
  if @item.save
    redirect_to root_path
  else
    render :new
    
  end
  end

  private
  def item_params
    params.permit(images_attributes: [:src])
  end
end
