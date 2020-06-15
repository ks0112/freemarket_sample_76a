class ImagesController < ApplicationController
  def index
    @item = Item.order('seller_id DESC')
    @items = Image.includes(:images).order('id DESC')
  end
  def show
    @item = Item.find(params[:id])
  end

end
