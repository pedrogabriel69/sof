class Vote < ApplicationRecord
  belongs_to :votable, required: false, polymorphic: true
  belongs_to :user
end
