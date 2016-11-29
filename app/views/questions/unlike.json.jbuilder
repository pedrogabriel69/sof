json.extract! @question, :id

json.up @question.votes_for.up.size
json.down @question.votes_for.down.size
json.rating @question.votes_for.up.size - @question.votes_for.down.size
