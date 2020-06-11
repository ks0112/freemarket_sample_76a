class UsersController < ApplicationController
  def show
    @parents = Category.where(ancestry: nil)
  end
  
  def new
    @user = User.new
  end
end
