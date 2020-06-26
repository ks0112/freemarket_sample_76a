# README

<h1 align="center">フリーマーケットサイト</h1>

- メルカリクローンのフリーマーケットサイトです。
- TECH::CAMP 76期短期集中コースAチームで作成。
- 作成期間 2020/6/2 ~ 2020/6/23
![image](https://user-images.githubusercontent.com/64839248/85387107-6056d980-b57f-11ea-9802-63c2959e800a.png)
![image](https://user-images.githubusercontent.com/64839248/85387281-94ca9580-b57f-11ea-886c-df18d050cfe4.png)
## :paperclip: 主な使用言語
<a><img src="https://user-images.githubusercontent.com/39142850/71774533-1ddf1780-2fb4-11ea-8560-753bed352838.png" width="70px;" /></a> <!-- rubyのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774548-731b2900-2fb4-11ea-99ba-565546c5acb4.png" height="60px;" /></a> <!-- RubyOnRailsのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774618-b32edb80-2fb5-11ea-9050-d5929a49e9a5.png" height="60px;" /></a> <!-- Hamlのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774644-115bbe80-2fb6-11ea-822c-568eabde5228.png" height="60px" /></a> <!-- Scssのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774768-d064a980-2fb7-11ea-88ad-4562c59470ae.png" height="65px;" /></a> <!-- jQueryのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774786-37825e00-2fb8-11ea-8b90-bd652a58f1ad.png" height="60px;" /></a> <!-- AWSのロゴ -->

## 機能紹介
- 新規会員登録・ログイン機能
- ログイン時の商品の出品、商品の編集機能
- ログインしていない方でも商品の一覧、詳細を閲覧可能です。
- 住所、クレジットカード登録後商品の購入ができます。
- 自分が出品した商品をマイページで確認できます。

## 実装内容の紹介
- 商品情報編集機能
- 商品詳細表示機能
- 商品削除機能
- 商品出品機能
- ユーザー新規登録、ログイン機能
- カテゴリー機能
- カテゴリ別商品検索機能
- 商品検索機能
- 商品購入機能
- 商品一覧表示機能
- マイページ機能
- pay.jpのapiを用いたクレジットカード登録・削除機能 & 商品購入機能

## サイトURL紹介
- ユーザー名: ks0112
- パスワード: sibuya_76a
- IPアドレス:http://3.115.42.47/

# :page_facing_up: DB設計

## ER図
<img src="https://user-images.githubusercontent.com/64722228/85387618-fe4aa400-b57f-11ea-9bd3-aade4c681811.png">

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
|item_id|integer|oreign_key: true|
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
|seller|integer|null: false|foreign_key: "seller_id"|
|buyer|integer|foreign_key: buyer_id"|optional: true|
|name|string|null: false|
|description|string|null: false|
|price|integer|null: false|
|category_id|integer|null: false|foreign_key: true|dependent: :destroy|
|brand_id|integer|foreign_key: true|dependent: :destroy, optional: :true|
|status|integer|null: false|
|cost|integer|null: false
|prefecture_id|integer|null: false|
|days|integer|null: false|
### Association
- belongs_to :seller
- belongs_to :buyer
- belongs_to :category
- belongs_to :brand
- has_many :images
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
- has_ancesrty
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
- has_many :destination
- has_many :card
- has_many :items
- has_many :selling_items
- has_many :bought_items
- has_many :sold_items
