class AnswersChannel < ApplicationCable::Channel
  def follow_answer
    stream_from "answers-question-#{params['id']}"
  end
end
