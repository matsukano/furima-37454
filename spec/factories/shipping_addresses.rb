FactoryBot.define do
  factory :shipping_address do
    association :order
  end
end
