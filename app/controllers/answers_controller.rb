class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_question, only: [:new, :create]

  def index
    @answers = Answer.all
  end

  def show
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to questions_path
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
    redirect_to questions_path
  end

  private

  def set_answer
    @answer = Answer.find(params[:id]).becomes(Answer)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body).merge(user: User.last)
  end
end
