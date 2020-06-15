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
    @item = Item.find(params[:id])
    @item.update(item_update_params)
    # @images = Image.where(item_id: @item.id)
    # image_form_count = item_params_update[:item_images_attributes].to_hash.length
    # image_count = @images.length
    # delete_image_count = 0
    # count = 0
    # while count < image_count do
    #   if item_params_update[:item_images_attributes].values[count][:"_destroy"] == "1"
    #     delete_image_count += 1
    #   end
    #   count += 1
    # end
    # if delete_image_count != image_count || image_form_count != image_count
    #   @item.update(item_params_update)
    #   redirect_to root_path
    # else
    #   redirect_to edit_item_path(params[:id])
    # end

    product = Item.find(params[:id])
    if product.user_id == current_user.id
      product.update(product_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def edit
    @item = Item.find(params[:id])
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
  # 画像
  def item_update_params
    params.require(:item).permit(
      :name,
      [images_attributes: [:image, :_destroy, :id]])
  end
end
