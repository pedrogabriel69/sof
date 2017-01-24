class Follow < ApplicationRecord
  belongs_to :followable, required: false, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: {scope: :followable_id}
end
