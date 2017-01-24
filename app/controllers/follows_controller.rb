class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create, :destroy]

  respond_to :js

  def create
    respond_with @follow = @question.follows.create(user: current_user)
    authorize! :create, @follow
  end

  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
    authorize! :destroy, @follow
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
