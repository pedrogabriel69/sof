json.extract! @question, :id

json.up @question.votes_for_up
json.down @question.votes_for_down
json.rating @question.votes_for_up - @question.votes_for_down
