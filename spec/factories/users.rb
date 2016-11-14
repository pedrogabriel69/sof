FactoryGirl.define do
  sequence :email do |_n|
    'test#{n}@test.com'
  end

  factory :user do
    name 'MyName'
    email
    password '1qwerty111'
    password_confirmation '1qwerty111'
  end
end
