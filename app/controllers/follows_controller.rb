class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create, :destroy]

  authorize_resource

  respond_to :js

  def create
    respond_with @follow = @question.follows.create(user: current_user)
  end

  def destroy
    @follow = Follow.find(params[:id])
    respond_with @follow.destroy
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
