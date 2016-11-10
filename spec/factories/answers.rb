FactoryGirl.define do
  factory :answer do
    body 'MyText'
  end

  factory :invalid_answer, class: 'Answer' do
    bidy nil
  end
end
