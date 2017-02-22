ready = ->
  console.log('comments ready')
  $('.question').on 'click', '.question-comment-link', (e) ->
    e.preventDefault();
    $(this).hide();
    $("form#new-question-comment").show();

  $('.answers').on 'click', '.answer-comment-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $("form#new-comment-" + answer_id).show();

  App.cable.subscriptions.create({ channel: 'CommentsChannel', id: gon.question_id }, {
    connected: ->
      console.log 'Connected to CommentsChannel, question_id:', gon.question_id
      @perform 'follow_comment'

    received: (data) ->
      console.log 'Received!', data
      comment = $.parseJSON(data)
      if comment.commentable_type is 'Question'
        return if $("#comment_#{comment.id}")[0]?
        $('.comments').append(JST["comment"]({comment: comment}));
        $("form#new-question-comment").hide();
        $("form#new-question-comment input[type=text]").val('');
      else
        return if $("#comment_#{comment.id}")[0]?
        $('#comment_answer_' + comment.commentable_id).append(JST["comment"]({comment: comment}));
        $("form#new-comment-" + comment.commentable_id).hide();
        $("form#new-comment-#{comment.commentable_id} input[type=text]").val('');
  })

$(document).on('turbolinks:load', ready)
