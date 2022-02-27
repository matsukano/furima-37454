class Item < ApplicationRecord
  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :item_category_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :item_condition_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :shipping_charge_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :days_to_ship_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  belongs_to :user
  #has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship
end
