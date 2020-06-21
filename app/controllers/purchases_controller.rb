class PurchasesController < ApplicationController
  before_action :set_item, only:[:buy, :index]

  def index
    card = Card.find_by(user_id: current_user.id)
    # if card.blank?
    #   #登録された情報がない場合にカード登録画面に移動
    #   redirect_to new_card_path
    # else
    # Payjp.api_key = "sk_test_6d5bbe82c50db611a63aeefa"
    # #保管した顧客IDでpayjpから情報取得
    # customer = Payjp::Customer.retrieve(card.customer_id)
    # #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    # @default_card_information = customer.cards.retrieve(card.card_id)
    # end
    unless @item.buyer_id.blank?
      redirect_to root_path and return
    end
    if current_user.destinations.blank?
      redirect_to new_destination_path
    elsif card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path, data: { turbolinks: false}
    else
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    #保管した顧客IDでpayjpから情報取得
    customer = Payjp::Customer.retrieve(card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def buy
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy' #日本円
  )
  @item.update( buyer_id: current_user.id) #seller_idに購入者のuser_idを追加し、製品のステータスをsold outに変更
  redirect_to root_path
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end
end
