FactoryGirl.define do
  sequence :email do |n|
    'user#{n}@test.com'
  end

  factory :user do
    name 'MyString'
    email
    password '1qwerty111'
    password_confirmation '1qwerty111'
  end
end
