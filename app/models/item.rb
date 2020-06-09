class Item < ApplicationRecord
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
  belongs_to :category, dependent: :destroy
  belongs_to :brand, dependent: :destroy
  has_many :images, dependent: :destroy
  include ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :cost
  belongs_to_active_hash :days
end