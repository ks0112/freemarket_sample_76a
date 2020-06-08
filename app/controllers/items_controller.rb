class ItemsController < ApplicationController
  def index
    @item = Item.limit(3).order('created_at DESC')
    @category = Category.all
  end

  def show
  end

  def edit
  end

  def new
  end
end
