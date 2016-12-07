ready = ->
  $('.question').on 'click', '.question-comment-link', (e) ->
    e.preventDefault();
    $(this).hide();
    $("form#new_comment").show();

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
