FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:name) { |n| "user#{n}" }
    password 'Qwerty$4'
    password_confirmation 'Qwerty$4'
  end
end
