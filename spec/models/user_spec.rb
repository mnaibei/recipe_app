# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user.name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without a password' do
    user.password = nil
    expect(user).not_to be_valid
  end

  it 'is invalid with a short password' do
    user.password = '12345'
    expect(user).not_to be_valid
  end

  it 'is invalid with a non-unique email' do
    FactoryBot.create(:user, email: 'john@example.com')
    expect(user).not_to be_valid
  end
end
