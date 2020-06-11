class ItemsController < ApplicationController
  before_action :set_current_user_items,only:[:p_exhibiting,:p_soldout]
  before_action :set_user,only:[:p_exhibiting,:p_soldout]


  def index
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
    else
      redirect_to new_item_path,data: { turbolinks: false }
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end


  def p_exhibiting #出品中のアクション

  end

  def p_soldout    #売却済みのアクション

  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :status, :cost, :days,
      images_attributes: [:src], brand_attributes: [:id, :name], category_ids: []).merge(seller_id: current_user.id)
  end

  def set_current_user_items
    if user_signed_in?
      @items = current_user.items.includes(:seller,:buyer,:item_images)
    else
      redirect_to new_user_session_path
    end
  end

  def set_user
    @user = User.find(current_user.id)
  end
end



# def new
#   @item = Item.new(item_params)
  
# end

# def create
#   @item = Item.new(item_params)
#   # binding.pry
# if @item.save
#   redirect_to root_path
# else
#   render :new

# end
# end

# private
# def item_params
#   params.permit(images_attributes: [:src])
# end
