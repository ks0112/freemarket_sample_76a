class UsersController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)    
    @items = Item.where(seller_id: current_user.id)
  end

  def show
    @parents = Category.where(ancestry: nil)
  end

  def new
    @user = User.new
  end

end
