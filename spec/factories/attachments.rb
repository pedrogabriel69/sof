FactoryGirl.define do
  factory :attachment do
    file File.open(Rails.root.join('README.rdoc'), 'r')
  end
end
