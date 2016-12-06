ready = ->
  $('.answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $("form#edit-answer-" + answer_id).show();

  $('.vote-answer').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('#rating_' + response.id).replaceWith(response.rating)

  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      console.log 'Connected to AnswersChannel'
      @perform 'follow'

    received: (data) ->
      console.log 'Received!', data
      answer = $.parseJSON(data)
      console.log(gon.user_id)
      $('#answer_question_' + answer.question_id).append(JST["answer"]({answer: answer}));
  })

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
$(document).on("turbolinks:load", ready)
