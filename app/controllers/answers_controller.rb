class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:update, :destroy]
  before_action :set_question, only: [:create, :destroy]

  def create
    @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
    flash[:notice] = 'Your answer successfully created.' if @answer.save
  end

  def update
    @question = @answer.question
    flash[:notice] = 'Your answer successfully updated.' if @answer.update(answer_params.merge(user_id: current_user.id))
  end

  def destroy
    if current_user.author?(@answer)
      @answer.destroy
      redirect_to @question
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
