// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function () {
    $('#change-name').click(function (e) {
//        e.stopPropagation();
//        e.preventDefault();
        var value = $('#change-name-form input').val();
//        console.log('value: ' + value);
        $.ajax({
            type: 'POST',
            url: "/simple_chat/users/change_name",
            data: {name: value},
            dataType: "script",
            complete: function (data) {
                eval(data.responseText);
            }});
//          complete: function(jqXHR) {
//              if(jqXHR.readyState === 4) {
//              }
//          }
//      });
//        console.log('val: ' + value);
//        var result = jQuery.post("/simple_chat/users/change_name",{name: value},function (data) {
//            console.log('response: ' + data);
//            eval(data);
//        });
//        result.done(function(){
//            console.log('jqXHR is done')
//        } );
        $('#change-name-form input').val('');
    });
};
$(document).ready(ready)
$(document).on('page:load', ready)