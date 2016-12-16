FactoryGirl.define do
  factory :answer do
    sequence(:body) { |n| "answer_body#{n}" }
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end
