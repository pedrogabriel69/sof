class CommentsController < ApplicationController
  include Commented

  before_action :set_commented, only: [:create]
  after_action :publish_comment, only: [:create]

  respond_to :js

  authorize_resource

  def create
    respond_with(@comment = @commented.comments.create(comment_params.merge(user: current_user)))
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def publish_comment
    return if @comment.errors.any?
    ActionCable.server.broadcast(
      "comments-question-#{@comment.return_id}",
      render_to_string(template: 'comments/comment.json.jbuilder')
    )
  end
end
