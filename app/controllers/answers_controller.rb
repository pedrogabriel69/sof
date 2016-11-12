class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:update, :create, :destroy, :edit]

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body).merge(user: current_user)
  end
end
