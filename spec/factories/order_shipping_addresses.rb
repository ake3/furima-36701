FactoryBot.define do
  factory :order_shipping_address do
    postal_code { '123-4567' }
    prefecture_id { '5' }
    city { '仙台市' }
    addresses { '1−1' }
    building { '仙台ハイツ' }
    phone_number { '08011112222' }
    token {'tok_abcdefghijk00000000000000000'}
  end
end
