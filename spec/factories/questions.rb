FactoryGirl.define do
  sequence :title do |_n|
    'title#{n}'
  end

  sequence :body do |_n|
    'body#{n}'
  end

  factory :question do
    title
    body
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
