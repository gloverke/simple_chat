// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready = function() {
	if(gon.room_id == null)
		console.error("Room Id Not Set");
	var source = new EventSource(gon.events_path);
	console.log('subscribing to even channel: ' + gon.events_path + ' event: ' + 'messages_' + gon.room_id);
	source.addEventListener('messages_' + gon.room_id + '.chat', function(e) {
		var message = jQuery.parseJSON(e.data);
        $('#user-list [data-user-id="' +message.user_id + '"]').toggleClass("spoke");
		$('#chat-output').append("<div>" + message.name + ':' + message.content + "</div>");
        setTimeout(function(){
        ($('#user-list [data-user-id="' +message.user_id + '"]')).toggleClass("spoke");
        }, 50);

	});
    source.addEventListener('messages_' + gon.room_id + '.user_entered', function(e) {
        var message = jQuery.parseJSON(e.data);


    });
    source.addEventListener('messages_' + gon.room_id + '.user_left', function(e) {
        var message = jQuery.parseJSON(e.data);
        $('#user-list [data-user-id="' +message.id + '"]').remove();
    });
    source.addEventListener('messages_' + gon.room_id + '.user_rename', function(e) {
        var message = jQuery.parseJSON(e.data);
        $('#user-list [data-user-id="' +message.id + '"]').text(message.name);
    });

	$('#send-chat').click(function(e) {
		$.post(gon.chat_url, {
			name : $('#current-user').text(),
			content : $("#chat-input").val(),
			room_id : gon.room_id
		});
	});
	$('#chat-input').keypress(function(e) {
		if(e.which == 13) {
			$.post(gon.chat_url, {
				name : $('#current-user').text(),
				content : $("#chat-input").val(),
				room_id : gon.room_id
			});
		}
	});
};
$(document).ready(ready);
$(document).on('page:load', ready);