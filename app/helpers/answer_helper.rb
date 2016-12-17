module AnswerHelper
  def best_btn(question, answer)
    btn_class = answer.flag ? '' : '-empty'
    link_to '', best_question_answer_path(question, answer),
            method: :put, remote: true, class: "glyphicon glyphicon-star#{btn_class}"
  end
end
