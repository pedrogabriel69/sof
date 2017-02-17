ready = ->
  $('.answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $("form#edit-answer-" + answer_id).show();

  $('.vote-answer').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('#rating_' + response.id).replaceWith(response.rating)

  App.cable.subscriptions.create({ channel: 'AnswersChannel', id: gon.question_id }, {
    connected: ->
      console.log 'Connected to AnswersChannel, question_id:', gon.question_id
      @perform 'follow_answer'

    received: (data) ->
      console.log 'Received!', data
      answer = $.parseJSON(data)
      question = answer.question
      console.log('User Id:', gon.user_id)
      console.log('Answer Id:', answer.id)
      return if $("#answer_#{answer.id}")[0]?
      $('.answers').append(JST["answer"]({answer: answer, question: question}));
  })

$(document).on('turbolinks:load', ready)
