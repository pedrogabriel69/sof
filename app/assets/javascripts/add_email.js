$(document).ready(function(){
    $('.sendButton').attr('disabled',true);
    $('#add-email').keyup(function(){
        if($(this).val().length !=0)
            $('.sendButton').attr('disabled', false);
        else
            $('.sendButton').attr('disabled',true);
    })
});
