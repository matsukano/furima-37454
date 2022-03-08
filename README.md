## users 

| Column               | Type   | Options                  |
| -------------------- | ------ | ------------------------ |
| nickname             | string | null: false,unique: true |
| email                | string | null: false,unique: true |
| encrypted_password   | string | null: false              |
| last_name            | string | null: false              |
| first_name           | string | null: false              |
| last_name_kana       | string | null: false              |
| first_name_kana      | string | null: false              |
| date_of_birth        | date   | null: false              |

### Association
- has_many :items
- has_many :orders


## items

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| item_description   | text       | null: false                    |
| item_category_id   | integer    | null: false                    |
| item_condition_id  | integer    | null: false                    |
| shipping_charge_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| days_to_ship_id    | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order
- has_one_attached :image


## orders テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address


## shipping_addresses

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| order         | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| municipality  | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |

### Association
- belongs_to :order