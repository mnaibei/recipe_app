FactoryBot.define do
  factory :recipe do
    name { 'Apple Pie' }
    preparation_time { '00:30:00' }
    cooking_time { '00:45:00' }
    description { 'Delicious apple pie recipe!' }
    public { true }
    association :user
  end
end
