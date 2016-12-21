FactoryGirl.define do
  factory :comment do
    sequence(:body) { |n| "comment_body#{n}" }
  end
end
