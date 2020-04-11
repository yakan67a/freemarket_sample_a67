# README

# Database creation

## users_table

|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|nickname|string|unique: true, null: false|
|email|string|unique:true, null false|
|password|string|null: false|
|name_first|string|null: false|
|name_last|string|null: false|
|name_first_kana|string|null: false|
|name_last_kana|string|null: false|
|birth|date|null: false|
|profile_image|string|
|profile|text|
|rate_id|integer|foreign_key:true|ｖ
|credit_card_id|integer|foreign_key:true, null:false|
|profit|integer|
|comment_id|integer|foreign_key: true|

### Association
- has_many :items
- has_many :ratings dependent: :destroy
- has_many :comments dependent: :destroy
- belongs_to :sns_credential dependent: :destroy
- has_one :credit_card dependent: :destroy
- has_one :shipping_address dependent: :destroy


## items_table

|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|user_id|integer|foreign_key: true|
|item_name|string|null: false|
|item_description|text| null: false|
|images_id|integer|foreign_key:true, null: false|
|category_id|integer|foreign_key:true, null: false|
|brand_id|integer|foreign_key:true|
|condition|string| null: false|
|shipping_costs|string| null:false|
|shipping_area_id|integer| foreign_key:true, null false|
|days_to_ship|string| null: false|
|price |integer|null: false|
|comment_id|integer|foreign_key: true|

### Association
- has_many :item_images dependent: :destroy
- has_many :comments dependent: :destroy
- belongs_to :category
- belongs_to :brand
- belongs_to :prefectures
- belongs_to :user
- belongs_to :rating dependent: :destroy


## shipping_address_table

|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name_first|string|null:false|
|name_last|string|null:false|
|name_first_kana|string|null:false|
|name_last_kana|string|null:false|
|zip_code|string|null:false|
|prefecture_id|integer|foreign_key:true, null:false|
|city|string|null:false|
|street_adress|string|null:false|
|building|string|
|phone_number|string|
|user_id|integer|foreign_key:true|

### Association
- belongs_to :prefecture
- belongs_to :users


## credit_cards_table

|Column|Type|Options|
|------|----|-------|
|ID|integer| null:false|
|user_id|integer|foreign_key:true|
|customer_id|integer|foreign_key:true|

### Association
- belongs_to :user


## sns_credentials_table

|Column|Type|Options|
|------|----|-------|
|ID|integer|null false|
|provider|string|
|uid|integer|
|user_id|integer|foreign_key|

### Association
- belongs_to : user

## ratings_table

|Column|Type|Options|
|------|----|-------|
|ID|integer|null:false|
|rate|integer|null: false|
|user_id|integer|foregn_key:true,null: false|
|item_id|integer|foregn_key:true,null: false|

### Association
- belongs_to :user
- belongs_to :item

## comments_table

|Column|Type|Options|
|------|----|-------|
|ID|integer| null:false|
|comment|text|null: false|
|user_id|integer|foregn_key:true,null:false|
|item_id|integer|foregn_key:true,null:false|

### Association
- belongs_to :user
- belongs_to :item

## brands_table

|Column|Type|Options|
|------|----|-------|
|ID|integer| null:false|
|name|string|

### Association
- has_many : items


## item_images_table

|Column|Type|Options|
|------|----|-------|
|ID|integer|null:false|
|item_id|integer|foreign_key:true, null:false|
|image_URL|text|null:false|

### Association
- belongs_to :item

## category_table

|Column|Type|Options|
|------|----|-------|
|ID|integer|null:false|
|name|string|null:false|

### Association
- has_many : items
- has_ancestry