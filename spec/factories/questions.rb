FactoryGirl.define do
  factory :question do
    sequence(:title) { |n| "title#{n}" }
    sequence(:body) { |n| "body#{n}" }
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
