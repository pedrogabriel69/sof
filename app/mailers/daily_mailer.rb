class DailyMailer < ApplicationMailer

  def digest(user, questions)
    @user = user
    @questions = questions

    mail to: user.email
  end

  def new_answer(user, answer)
    @user = user
    @answer = answer

    mail to: user.email
  end
end
