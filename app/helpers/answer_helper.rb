module AnswerHelper
  def best_btn(question, answer)
    case answer.flag
    when true
      btn_class = 'btn-success'
    when false
      btn_class = 'btn-default'
    end

    link_to "Best", best_question_answer_path(question, answer), method: :put, remote: true, class: "btn #{btn_class} btn-xs"
  end
end
