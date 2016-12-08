json.extract! @comment, :id, :body, :user_id, :commentable_type, :commentable_id
json.user @comment.user, :id, :name
json.time_ago (time_ago_in_words @comment.created_at)
