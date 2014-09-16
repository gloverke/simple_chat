// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready = function() {
	if(gon.room_id == null)
		console.error("Room Id Not Set");
	var source = new EventSource(gon.events_path);
	console.log('subscribing to even channel: ' + gon.events_path + ' event: ' + 'messages_' + gon.room_id);
	source.addEventListener('messages_' + gon.room_id + '.chat', function(e) {
		console.log('recevied message');
		console.log(e);
		var message = jQuery.parseJSON(e.data);
		$('#chat-output').append("<div>" + message.name + ':' + message.content + "</div>");
	});
	$('#send-chat').click(function(e) {
		console.log(gon.chat_url + " content: " + $("#chat-input").val());
		$.post(gon.chat_url, {
			name : "XXXX",
			content : $("#chat-input").val(),
			room_id : gon.room_id
		});
	});
	$('#chat-input').keypress(function(e) {
		if(e.which == 13) {
			$.post(gon.chat_url, {
				name : "XXXX",
				content : $("#chat-input").val(),
				room_id : gon.room_id
			});
		}
	});
};
$(document).ready(ready);
$(document).on('page:load', ready);