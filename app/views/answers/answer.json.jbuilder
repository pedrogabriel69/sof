json.extract! @answer, :id, :question_id, :body, :user_id
json.user @answer.user, :id, :name
json.question @question, :id, :title, :body, :user_id
json.update_url  question_answer_path(@question, @answer)
json.destroy_url question_answer_path(@question, @answer)
json.time_ago (time_ago_in_words @answer.created_at)


json.attachments @answer.attachments do |attach|
  json.id attach.id
  json.file_name attach.file.identifier
  json.file_url attach.file.url
end
