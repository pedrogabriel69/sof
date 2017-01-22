FactoryGirl.define do
  factory :follow do
    user { create(:user) }
  end
end
