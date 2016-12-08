ready = ->
  $('.question').on 'click', '.question-comment-link', (e) ->
    e.preventDefault();
    $(this).hide();
    $("form#new_comment").show();

  $('.answers').on 'click', '.answer-comment-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $("form#new-comment-" + answer_id).show();

  App.cable.subscriptions.create({ channel: 'CommentsChannel', id: gon.question_id }, {
    connected: ->
      console.log 'Connected to CommentsChannel'
      console.log('Question Id:', gon.question_id)
      @perform 'follow_comment'

    received: (data) ->
      console.log 'Received!', data
      comment = $.parseJSON(data)
      if comment.commentable_type is 'Question'
        return if $("#comment_#{comment.id}")[0]?
        $('.comments').append(JST["comment"]({comment: comment}));
      else
        return if $("#comment_#{comment.id}")[0]?
        $('#comment_answer_' + comment.commentable_id).append(JST["comment"]({comment: comment}));
  })

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
