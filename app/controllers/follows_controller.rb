class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create, :destroy]
  before_action :set_follow, only: :destroy

  respond_to :js

  def create
    authorize! :can_subscribe?, @question
    respond_with @follow = @question.follows.create(user: current_user)
  end

  def destroy
    authorize! :destroy, @follow
    respond_with @follow.destroy
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_follow
    @follow = Follow.find(params[:id])
  end
end
