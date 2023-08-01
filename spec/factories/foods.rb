FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "Apple #{n}" } # Use a sequence to generate unique names
    measurement_unit { 'piece' }
    price { 1.99 }
    association :user
  end
end
