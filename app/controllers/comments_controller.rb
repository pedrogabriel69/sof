class CommentsController < ApplicationController
  include Commented

  before_action :set_commented, only: [:create]
  after_action :publish_comment, only: [:create]

  def create
    @comment = @commented.comments.build(comment_params.merge(user: current_user))
    flash[:notice] = 'Your comment successfully created.' if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def publish_comment
    return if @comment.errors.any?
    ActionCable.server.broadcast(
      'comments',
      render_to_string(template: 'comments/comment.json.jbuilder')
    )
  end
end
