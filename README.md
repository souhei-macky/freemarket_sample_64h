# README


# データベース設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true, default: “”|
|encrypted_password|string|null: false, default: “”|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|year|string|null: false|
|month|string|null: false|
|day|string|null: false|
|image|text||
|uid|string|null: false|
|provider|string|null: false|
### Association
- has_many :items, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :credit_card, dependent: :destroy
- has_one :address, dependent: :destroy

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|zip_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|number|string|null: false|
|building|string||
|phone_number|string||
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|customer_id|integer|null: false|
|card_id|integer|null: false|
### Association
- belongs_to :user


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|price|integer|null: false|
|shopping_status|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|brands_category_id|integer|null: false, foreign_key: true|
|size_id|integer|null: false, foreign_key: true|
|item_condition_id|integer|null: false, foreign_key: true|
### Association
- has_many :images, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :comments, dependent: :destroy
- belongs_to :user
- belongs_to :category
- belongs_to :brands_category
- belongs_to :size
- belongs_to :content_condition

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :items
### memo
- Gemのancestryを使用する。

## brands_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items

## sizeテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- belongs_to :item

## item_conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- belongs_to :item

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item