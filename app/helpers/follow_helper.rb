module FollowHelper
  def follow_btn(question)
    follow = question.follows.where(user: current_user).first
    btn_class = follow.present? ? 'btn-danger' : 'btn-success'
    btn_text = follow.present? ? 'Unsubscribe' : 'Subscribe'
    url = follow.present? ? [question, follow] : question_follows_path(question)
    method = follow.present? ? :delete : :post
    link_to btn_text.to_s, url, method: method, remote: true, class: "btn #{btn_class} btn-sm"
  end

  def unsubscribe_btn(question)
    btn_class = question.check_follow ? 'btn-danger' : 'btn-success'
    btn_text = question.check_follow ? 'Unsubscribe' : 'Subscribe'
    link_to btn_text.to_s, unsubscribe_question_path(question), method: :put, remote: true, class: "btn #{btn_class} btn-sm"
  end
end
