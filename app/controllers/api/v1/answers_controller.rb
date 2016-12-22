class Api::V1::AnswersController < Api::V1::BaseController
  load_and_authorize_resource

  def index
    respond_with @answers
  end

  def show
    respond_with @answer
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(user: current_resource_owner))
    respond_with @answer, location: [@question, @answer]
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
