class CardsController < ApplicationController

  require 'payjp'

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
  end


  def pay #payjpとCardのデータベース作成
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    #保管した顧客IDでpayjpから情報取得
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(current_user.id)
      else
        redirect_to pay_cards_path
      end
    end
  end

  #削除予定
  # def buy #クレジット購入
  #     @item = Item.find(params[:item_id])
  #    # 購入した際の情報を元に引っ張ってくる
  #     card = current_user.credit_card
  #    # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
  #     Payjp.api_key = "sk_test_6d5bbe82c50db611a63aeefa"
  #    # キーをセットする(環境変数においても良い)
  #     Payjp::Charge.create(
  #     amount: @product.price, #支払金額
  #     customer: card.customer_id, #顧客ID
  #     currency: 'jpy', #日本円
  #     )
  #    # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
  #     if @item.update(status: 1, buyer_id: current_user.id)
  #       flash[:notice] = '購入しました。'
  #       redirect_to controller: "products", action: 'show'
  #     else
  #       flash[:alert] = '購入に失敗しました。'
  #       redirect_to controller: "products", action: 'show'
  #     end
  #    #↑この辺はこちら側のテーブル設計どうりに色々しています
  # end

  def destroy #PayjpとCardデータベースを削除
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to new_card_path
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to new_card_path 
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

end
