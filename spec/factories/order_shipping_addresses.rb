FactoryBot.define do
  factory :order_shipping_address do
    postal_code    {'123-4567'}
    prefecture_id  {1}
    municipality   {'横浜市'}
    house_number   {'青山'}
    building_name  {'柳ビル'}
    phone_number   {'09012345678'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
