class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy, :like, :unlike]

  def index
    @questions = Question.all.order('created_at DESC')
    @question = Question.new
  end

  def show
    @answer = Answer.new
    # @answer.attachments.build
  end

  def new
    @question = Question.new
    # @question.attachments.build
    render :new, layout: false
  end

  def edit
    render :edit, layout: false
  end

  def create
    @question = Question.new(question_params.merge(user_id: current_user.id))

    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      flash[:notice] = 'Fail, try again.'
    end
  end

  def update
    if @question.update(question_params.merge(user_id: current_user.id))
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if current_user.author?(@question)
      @question.destroy
      redirect_to questions_path
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
