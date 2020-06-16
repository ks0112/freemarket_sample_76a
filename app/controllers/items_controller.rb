class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_current_user_items,only:[:p_exhibiting,:p_soldout]
  before_action :set_user,only:[:p_exhibiting,:p_soldout]
  # before_action :set_item, only:[:show, :destroy, :edit, :update, :purchase, :payment]

  require 'payjp'

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
    @item = Item.find(params[:id])
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

  def buy
    @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = "sk_test_6d5bbe82c50db611a63aeefa"
    Payjp::Charge.create(
    :amount => @item.price,）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  @item.update( buyer_id: current_user.id)
  redirect_to action: 'done' #完了画面に移動
  end

  def done
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
end
