class NewAnswerFollowJob < ApplicationJob
  queue_as :default

  def perform(answer)
    answer.question.follows.each do |follow|
      DailyMailer.new_answer_follow(follow.user, answer).deliver_later
    end
  end
end
