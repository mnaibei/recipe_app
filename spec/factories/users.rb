FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { generate(:email) }
    password { 'password123' }
  end
end
