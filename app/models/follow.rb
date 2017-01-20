class Follow < ApplicationRecord
  belongs_to :followable, required: false, polymorphic: true
  belongs_to :user
end
