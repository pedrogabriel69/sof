class Vote < ApplicationRecord
  belongs_to :votable, required: false, polymorphic: true
  belongs_to :user

  validates :votable, :choice, :weight, presence: true
  validates :votable_type, inclusion: ['Question', 'Answer']
  validates :user_id, uniqueness: { scope: [:votable_type, :votable_id] }
end
