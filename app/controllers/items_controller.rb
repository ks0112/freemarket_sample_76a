class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_current_user_items,only:[:p_exhibiting,:p_soldout]
  before_action :set_user,only:[:p_exhibiting,:p_soldout]
  before_action :set_item, only:[:show, :destroy, :update, :purchase, :payment]


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
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @item = Item.new(item_params)
      render new_item_path
    end
  end

  def show
  end

  def update

    product = Item.find(params[:id])
    if product.seller_id == current_user.id
      product.update(product_params)
  
      redirect_to root_path
    else
      render 'edit'
    end

    
  end

  def edit
    # 画像取得
    @item = Item.find(params[:id])

    # カテゴリー
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
    # @item.build_brand
    # binding.pry

    # カテゴリー取得
    grandchild_category = @item.category
    child_category = grandchild_category.parent
    

    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
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

  def destroy
    image = Image.find(params[:id])
    image.destroy
  end


  def p_exhibiting #出品中のアクション

  end

  def p_soldout    #売却済みのアクション

  end
  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    # ここでfind_byを使うことでレディーしか取れてなかった
    @category_children = Category.find(params[:parent_id]).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find(params[:child_id]).children
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :cost_id, :days_id,:category_id,:status_id, :prefecture_id,
      images_attributes: [:id, :image], brand_attributes: [:id, :name]).merge(seller_id: current_user.id)
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

  end

  def product_params
    params.require(:item).permit(:name, :description, :price, :cost_id, :days_id,:category_id,:status_id, :prefecture_id,
    images_attributes: [:id, :image, :_destroy], brand_attributes: [:id, :name]).merge(seller_id: current_user.id)
  end

  
end
