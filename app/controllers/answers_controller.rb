class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create, :destroy, :best, :like, :unlike]
  before_action :set_answer, only: [:update, :destroy, :best, :like, :unlike]

  def create
    @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
    flash[:notice] = 'Your answer successfully created.' if @answer.save
  end

  def update
    @question = @answer.question
    flash[:notice] = 'Your answer successfully updated.' if @answer.update(answer_params)
  end

  def destroy
    @answer.destroy if current_user.author?(@answer)
  end

  def best
    flash[:notice] = 'Your choose best answer.' if @answer.choose_answer(@question)
  end

  def like
    @answer.liked_by current_user if !(current_user.author?(@answer))
    # render json: @question
  end

  def unlike
    @answer.downvote_from current_user if !(current_user.author?(@answer))
    # render json: @question
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
