FactoryGirl.define do
  factory :follow do
    user { create(:user) }
    followable_type "Question"
  end
end
