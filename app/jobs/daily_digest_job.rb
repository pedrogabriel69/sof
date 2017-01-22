class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each.each do |user|
      DailyMailer.digest(user, Question.last_questions.to_a).deliver_later
    end
  end
end
