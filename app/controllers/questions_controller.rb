class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer_comment, only: :show
  after_action :publish_question, only: [:create]

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new, layout: false)
  end

  def edit
    render :edit, layout: false
  end

  def create
    respond_with(@question = Question.create(question_params.merge(user_id: current_user.id)))
  end

  def update
    @question.update(question_params.merge(user_id: current_user.id))
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy) if current_user.author?(@question)
  end

  private

  def set_question
    @question = Question.find(params[:id])
    gon.question_id = @question.id
  end

  def build_answer_comment
    @answer = Answer.new
    @comment = Comment.new
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      render_to_string(template: 'questions/question.json.jbuilder')
    )
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
