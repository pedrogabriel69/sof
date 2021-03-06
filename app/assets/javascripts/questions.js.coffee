ready = ->
  $('.votes').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('.rating').replaceWith(response.rating)

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      console.log 'Connected to QuestionsChannel'
      @perform 'follow_question'

    received: (data) ->
      console.log 'Received!', data
      question = $.parseJSON(data)
      console.log('User Id:', gon.user_id)
      $('.list-questions').append(JST["question"]({question: question}));
  })

$(document).on('turbolinks:load', ready)
