class AnswersChannel < ApplicationCable::Channel
  def follow_answer
    stop_all_streams
    stream_from "answers-question-#{params['id']}"
  end
end
