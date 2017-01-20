class NewAnswerJob < ApplicationJob
  queue_as :default

  def perform(answer)
    DailyMailer.new_answer(answer.question.user, answer).deliver_later
  end
end
