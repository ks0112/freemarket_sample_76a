class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :destinations, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :items, dependent: :destroy
  # has_many :selling_items, class_name: "Item", foreign_key: "seller_id", -> { where("buyer_id is NULL") }
  has_many :bought_items, class_name: "Item", foreign_key: "buyer_id"
  # has_many :sold_items, class_name: "Item", foreign_key: "seller_id", -> { where("buyer_id is not NULL") }
end
