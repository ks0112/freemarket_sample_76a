class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_current_user_items,only:[:p_exhibiting,:p_soldout]
  before_action :set_user,only:[:p_exhibiting,:p_soldout]
  before_action :set_category, only: [:new, :edit, :update]
  before_action :set_item, only:[:edit, :show, :destroy, :update, :purchase, :payment]

  def index
    @item = Item.limit(3).order('created_at DESC')
    @womencategory = Item.where(category_id: 1..199).order('created_at DESC').limit(3)
    @mencategory = Item.where(category_id: 200..345).order('created_at DESC').limit(3)
    @entertainment = Item.where(category_id: 625..684).order('created_at DESC').limit(3)
    @items = Image.includes(:images).order('id DESC').limit(3)
  end

  def new
    @item = Item.new
    @item.images.new
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      # @item = Item.new(item_params)
      render new_item_path
    end
  end

  def edit
    grandchild_category = @item.category
    child_category = grandchild_category.parent
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end
    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end
    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
  end

  def update
    if @item.seller_id == current_user.id
      @item.update(item_params)
      redirect_to root_path
    else
      render 'edit'
    end
    # product = Item.find(params[:id])
    # if product.seller_id == current_user.id
    #   product.update(product_params)

    #   redirect_to root_path
    # else
    #   render 'edit'
    # end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy

  end

  def show
  end

  def destroy
  end

  def p_exhibiting #出品中のアクション

  end

  def p_soldout    #売却済みのアクション

  end

  def get_category_children
    @category_children = Category.find(params[:parent_name]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :cost_id, :days_id,:category_id,:status_id, :prefecture_id,
      images_attributes: [:id, :image, :_destroy], brand_attributes: [:id, :name]).merge(seller_id: current_user.id)
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

  def set_item
    @item = Item.find(params[:id])
  end


  # def product_params
  #   params.require(:item).permit(:name, :description, :price, :cost_id, :days_id,:category_id,:status_id, :prefecture_id,
  #   images_attributes: [:id, :image, :_destroy], brand_attributes: [:id, :name]).merge(seller_id: current_user.id)
  # end

end
