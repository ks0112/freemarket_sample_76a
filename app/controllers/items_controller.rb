class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_current_user_items,only:[:p_exhibiting,:p_soldout]
  before_action :set_user,only:[:p_exhibiting,:p_soldout]
  before_action :set_item, only:[:edit, :show, :destroy, :update, :purchase, :payment, :buy]
  require 'payjp'

  def index
    @parents = Category.where(ancestry: nil)
    # 新着アイテム
    @item = Item.limit(3).order('created_at DESC')
    # レディースアイテム
    @womencategory = Item.where(category_id: 1..199).order('created_at DESC').limit(3)
    # メンズアイテム
    @mencategory = Item.where(category_id: 200..345).order('created_at DESC').limit(3)
    # ベビー・キッズ
    @baby = Item.where(category_id: 346..480).order('created_at DESC').limit(3)
    # インテリア・住まい・小物
    @interia = Item.where(category_id: 481..624).order('created_at DESC').limit(3)
    # 本・音楽・ゲームアイテム
    @entertainment = Item.where(category_id: 625..684).order('created_at DESC').limit(3)
    # おもちゃ・ホビー・グッズ
    @hobby = Item.where(category_id: 685..797).order('created_at DESC').limit(3)
    # コスメ・香水・美容
    @beauty = Item.where(category_id: 798..897).order('created_at DESC').limit(3)
    # 家電・スマホ・カメラ
    @phone = Item.where(category_id: 898..983).order('created_at DESC').limit(3)
    # スポーツ・レジャー
    @sports = Item.where(category_id: 984..1092).order('created_at DESC').limit(3)
    # ハンドメイド
    @handmaid = Item.where(category_id: 1093..1146).order('created_at DESC').limit(3)
    # チケット
    @tickt = Item.where(category_id: 1147..1206).order('created_at DESC').limit(3)
    # 自動車・オートバイ
    @car = Item.where(category_id: 1207..1269).order('created_at DESC').limit(3)
    # その他
    @other = Item.where(category_id: 1270..1338).order('created_at DESC').limit(3)
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
      redirect_to new_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
    @grandchild = Category.find(@item.category_id)
    @child = @grandchild.parent
    @parent = @child.parent
  end

  def edit
    @grandchild_category = @item.category
    @child_category = @grandchild_category.parent
    @category_parent = @child_category.parent
    @category = Category.find(params[:id])
    # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
    @category_children = @item.category.parent.parent.children
    # 紐づく孫カテゴリーの一覧を配列で取得
    @category_grandchildren = @item.category.parent.children
    @category_parent_array = []
    @category_parent_array = Category.where(ancestry: nil)
    @category_children_array = []
    @category_children_array = Category.where(ancestry: @child_category.ancestry)
    @category_grandchildren_array = []
    @category_grandchildren_array = Category.where(ancestry: @grandchild_category.ancestry)
  end

  def update
    if @item.seller_id == current_user.id
      @item.category_id = nil unless params[:item][:category_id]
      if @item.update(item_params)
        # binding.pry
        redirect_to root_path
      else
        redirect_to edit_item_path(@item)
      end
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render action: :show
    end
  end

  def search
    @items = Item.search(params[:keyword])
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

  def buy
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy' #日本円
  )
    @item.update( buyer_id: current_user.id)
    redirect_to action: 'done' #完了画面に移動
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

end
