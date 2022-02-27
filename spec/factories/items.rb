FactoryBot.define do
  factory :item do
    item_name          {'オムライス'} 
    item_description   {'冷凍食品'}                
    item_category_id   {1}
    item_condition_id   {1}             
    shipping_charge_id  {1}               
    prefecture_id      {1}         
    days_to_ship_id    {1}          
    price              {300}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
