# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## destinationテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address_id|string|null: false|
|building_name|string|
|phone_number|string|
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture
## cardテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user
## brandテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|index: true|
### Association
- has_many :items
## imageテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item
## itemsテーブル
|Column|Type|Options|Options|
|------|----|-------|-------|
|seller|integer|null: false|foreign_key: true|
|buyer|integer|foreign_key: true|
|name|string|null: false|
|description|string|null: false|
|price|integer|null: false|
|category_id|integer|null: false|foreign_key: true|
|brand_id|integer|foreign_key: true|
|status|integer|null: false|
|cost|integer|null: false
|prefecture_id|integer|null: false|
|days|integer|null: false|
### Association
- belongs_to :seller, class_name: “user”, foreign_key: “seller_id”
- belongs_to :buyer, class_name: “user”, foreign_key: “buyer_id”
- belongs_to :category dependent: :destroy
- belongs_to :brand dependent: :destroy
- has_many :images dependent: :destroy
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :status
- belongs_to_active_hash :cost
- belongs_to_active_hash :days
## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|
### Association
- has_many :items
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_day|date|null: false|
### Association
- has_many :destination dependent: :destroy
- has_many :card dependent: :destroy
- has_many :items dependent: :destroy

