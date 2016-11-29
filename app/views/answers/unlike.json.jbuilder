json.extract! @answer, :id, :question_id

json.up @answer.votes_for.up.size
json.down @answer.votes_for.down.size
json.rating @answer.votes_for.up.size - @answer.votes_for.down.size
