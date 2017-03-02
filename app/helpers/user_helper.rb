module UserHelper
  def follow_btn(question)
    follow = question.follows.where(user: current_user).first
    btn_class = follow.present? ? 'btn-danger' : 'btn-success'
    btn_text = follow.present? ? 'Unsubscribe' : 'Subscribe'
    url = follow.present? ? [question, follow] : question_follows_path(question)
    method = follow.present? ? :delete : :post
    link_to btn_text.to_s, url, method: method, remote: true, class: "btn #{btn_class} btn-sm"
  end

  def digest_btn(user)
    btn_class = user.digest ? 'btn-danger' : 'btn-success'
    btn_text = user.digest ? 'off' : 'on'
    url = change_daily_digest_user_path

    link_to "Turn #{btn_text} DailyDigest", url, method: :put, remote: true, class: "btn #{btn_class} btn-sm"
  end
end
