class Question < ApplicationRecord
  include Votable
  
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
end
