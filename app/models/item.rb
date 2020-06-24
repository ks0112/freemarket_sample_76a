class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :cost
  belongs_to_active_hash :days
  belongs_to :category, dependent: :destroy
  belongs_to :brand, dependent: :destroy, optional: :true
  accepts_nested_attributes_for :brand
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id", optional: true
  validates_associated :images, :category
  validates :seller_id, :description, :category_id, :status_id, :cost_id, :prefecture_id, :days_id, :images, presence: true
  validates :name, presence: true, length: {maximum: 40}
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  def self.search(search)
    return Item.all unless search
    Item.where('text LIKE(?)', "%#{search}%")
  end

end