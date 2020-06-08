class Item < ApplicationRecord
  # いったん作成scope
  # scope :category, ->(category_id) {where(category_id: category_id).order(created_at: "DESC").limit(10)}
  # scope :brand, ->(brand_id) {where(brand_id: brand_id).order(created_at: "DESC").limit(10)}


  belongs_to :user, dependent: :destroy
  belongs_to :category, dependent: :destroy
  belongs_to :brand, dependent: :destroy
  has_many :images, dependent: :destroy
  include ActiveHash::Associations::ActiveRecordExtensions
  # /*13行目いったんコメントアウト県名*/
  # belongs_to_active_hash :prefecture
end