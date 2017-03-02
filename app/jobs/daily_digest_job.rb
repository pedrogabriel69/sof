class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    question = Question.last_questions.to_a
    User.where(digest: true).find_each.each do |user|
      DailyMailer.digest(user, question).deliver_later
    end
  end
end
