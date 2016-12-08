class CommentsChannel < ApplicationCable::Channel
  def follow_comment
    stream_from "comments-question-#{params['id']}"
  end
end
