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

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
