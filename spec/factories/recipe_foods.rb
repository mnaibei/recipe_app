FactoryBot.define do
  factory :recipe_food do
    quantity { 2 }
    association :recipe
    association :food
  end
end
