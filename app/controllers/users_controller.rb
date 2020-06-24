class UsersController < ApplicationController
  def index
    @items = Item.where(seller_id: current_user.id)
  end

  def show
    @parents = Category.where(ancestry: nil)
  end

  def new
    @user = User.new
  end

end
