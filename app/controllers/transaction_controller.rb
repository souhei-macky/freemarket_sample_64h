class TransactionController < ApplicationController

  before_action :set_item, only: [:show, :pay]
  before_action :set_card, only: [:show, :pay]

  def show
    #テーブルからpayjpの顧客IDを検索
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_credit_card_path
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    if @card
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      Payjp::Charge.create(
        amount: @item.price, #itemテーブルの価格情報を取得
        customer: @card.customer_id, #顧客ID
        currency:'jpy', #日本円
      )
      redirect_to done_transaction_index_path #完了画面に移動
    else
      redirect_to transaction_path(@item)
    end
  end

  def done
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = CreditCard.where(user_id: current_user.id).first
  end
end
