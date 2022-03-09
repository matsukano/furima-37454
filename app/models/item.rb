class Item < ApplicationRecord
  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :item_category_id, numericality: { other_than: 0 , message: "を入力してください"}
  validates :item_condition_id, numericality: { other_than: 0 , message: "を入力してください"}
  validates :shipping_charge_id, numericality: { other_than: 0 , message: "を入力してください"}
  validates :prefecture_id, numericality: { other_than: 0 , message: "を入力してください"}
  validates :days_to_ship_id, numericality: { other_than: 0 , message: "を入力してください"}
  validates :price, numericality: { only_integer: true, message: "は半角で入力してください" }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "は¥300〜¥9,999,999の範囲内で入力してください" }

  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship
end
