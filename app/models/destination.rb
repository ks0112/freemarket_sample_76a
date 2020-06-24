class Destination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :prefecture

  validates :user_id, presence: true
  validates :family_name, presence: true, format: { with:/\A[ぁ-んァ-ン一-龥]/}
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :first_name_kana,  presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :post_code, format: { with: /\A\d{7}\z/ }, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, format: { with: /\A[0-9]+\z/}, allow_blank: true
end
