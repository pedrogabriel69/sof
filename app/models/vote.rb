class Vote < ApplicationRecord
  belongs_to :votable, required: false, polymorphic: true, touch: true
  belongs_to :user

  validates :votable_type, inclusion: %w(Question Answer)
  validates :weight, inclusion: [-1, 1]
  validates :user_id, uniqueness: { scope: [:votable_type, :votable_id] }
end
