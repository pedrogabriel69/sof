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

  App.cable.subscriptions.create('CommentsChannel', {
    connected: ->
      console.log 'Connected to CommentsChannel'
      @perform 'follow'

    received: (data) ->
      console.log 'Received!', data
      comment = $.parseJSON(data)
      if comment.commentable_type is 'Question'
        $('.comments').append(JST["comment"]({comment: comment}));
      else
        $('#comment_' + comment.commentable_id).append(JST["comment"]({comment: comment}));
  })

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
