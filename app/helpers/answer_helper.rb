module AnswerHelper
  def best_btn(question, answer)
    btn_class = answer.flag ? 'btn-success' : 'btn-default'
    link_to 'Best', best_question_answer_path(question, answer),
            method: :put, remote: true, class: "btn #{btn_class} btn-xs"
  end
end
