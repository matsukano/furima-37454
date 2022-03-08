class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id, :item_id, :municipality, :house_number, :phone_number, :token
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end
  validates :phone_number, numericality: true, format: {with: /\d{10}|\d{11}/, message: 'is out of setting range' }
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
  
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, building_name: building_name, phone_number: phone_number )
  end
end