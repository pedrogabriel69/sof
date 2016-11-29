json.extract! @answer, :id, :question_id

json.up @answer.votes_for_up
json.down @answer.votes_for_down
json.rating @answer.votes_for_up - @answer.votes_for_down
