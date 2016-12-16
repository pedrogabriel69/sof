class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!
  before_action :set_question, only: [:update, :create, :destroy, :best]
  before_action :set_answer, only: [:update, :destroy, :best]
  before_action :build_comment, only: [:create, :update, :best]
  after_action :publish_answer, only: [:create]

  respond_to :js

  authorize_resource

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user_id: current_user.id)))
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
  end

  def destroy
    respond_with(@answer.destroy) if current_user.author?(@answer)
  end

  def best
    respond_with(@answer) if @answer.choose_answer(@question)
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def build_comment
    @comment = Comment.new
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "answers-question-#{@answer.question.id}",
      render_to_string(template: 'answers/answer.json.jbuilder')
    )
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
