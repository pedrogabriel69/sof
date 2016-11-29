ready = ->
  $('.votes').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('.rating').replaceWith(response.rating)


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
