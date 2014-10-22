// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function () {
    $('#current-user-row').click(function (e) {
        $('#change-name-row').removeClass('hide');
        $('#current-user-row').hide();
        $('#change-name-row').show();
        $('#change-name-row input').focus();

    });
    $('#new-name').bind("keypress", function(event) {
        if(event.which == 13) {
            event.preventDefault();
            var value = $('#change-name-form input').val();
            $.ajax({
                type: 'POST',
                url: "/simple_chat/users/change_name",
                data: {name: value},
                dataType: "script",
                complete: function (data) {
                    eval(data.responseText);
                }});
            $('#change-name-form input').val('');
            $('#change-name-row').hide();
            $('#current-user-row').show();

        }
    });
};
$(document).ready(ready)
$(document).on('page:load', ready)