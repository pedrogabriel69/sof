ready = ->
  $('.votes').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('.rating').replaceWith(response.rating)

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      console.log 'Connected!'
      # @perform 'echo', text: 'hello'
      @perform 'follow'

    received: (data) ->
      console.log 'Received!', data
      question = $.parseJSON(data)
      $('.list-questions').append question.body
  })


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
$(document).on("turbolinks:load", ready)
