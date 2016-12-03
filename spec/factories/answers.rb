FactoryGirl.define do
  factory :answer do
    body 'My Answer'
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end
