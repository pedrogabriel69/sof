class CommentsChannel < ApplicationCable::Channel
  def follow_comment
    stop_all_streams
    stream_from "comments-question-#{params['id']}"
  end
end
