class QuestionsChannel < ApplicationCable::Channel
  def follow_question
    stop_all_streams
    stream_from 'questions'
  end
end
