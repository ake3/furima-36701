# README

## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association
- has_many :items
- has_many :orders

## itemsテーブル

| Column        | Type       | Options                        |
| --------------| ---------- | ------------------------------ |
| name          | string     | null: false                    |
| explanation   | text       | null: false                    |
| category      | string     | null: false                    |
| status        | string     | null: false                    |
| shipping_cost | string     | null: false                    |
| prefecture    | string     | null: false                    |
| days          | string     | null: false                    |
| selling_price | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :order

## ordersテーブル

| Column        | Type       | Options                        |
| --------------| ---------- | ------------------------------ |
| payment_price | integer    | null: false                    |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :items
- has_one :shipping_address

## shipping_addressesテーブル

| Column       | Type       | Options                        |
| -------------| ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     | null: false                    |
| phone_number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association
- belongs_to :order