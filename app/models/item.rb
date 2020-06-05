class Item < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :category, dependent: :destroy
  belongs_to :brand, dependent: :destroy
  has_many :images, dependent: :destroy
  include ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end