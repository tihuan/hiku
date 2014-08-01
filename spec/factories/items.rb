# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "MyString"
    product_id 1
    quantity 1
    status 1
    ean 1
    favorite false
  end
end
