/// @desc Sends 
/// @param {struct} _contents Description
function send_command(_contents) {
	var arr = [_contents]
	if (struct_exists(_contents,"locations")) {
		if (!is_int64(_contents.locations[0])) {
			_contents.locations = int64(_contents.locations[0]);
		}
	}
	aa = json_stringify(arr)
	//show_debug_message(aa);
	
	var buffer = buffer_create(string_byte_length(aa), buffer_fixed,1)
	buffer_seek(buffer, buffer_seek_start, 0)
	buffer_write(buffer,buffer_text,aa)
	
	network_send_raw(global.socket, buffer, buffer_tell(buffer),network_send_text)
}

/// @desc Creates a Hint using the location ID and player ID
/// @param {any} location Location ID
/// @param {any} player Player ID
function send_hint(location, player) {
	var str = "[{\"player\":";
	str += string(player);
	str += ",\"locations\":[";
	str += string(location);
	str += "],\"cmd\":\"CreateHints\"}]";
	show_debug_message(str);
	var buffer = buffer_create(string_byte_length(str), buffer_fixed,1)
	buffer_seek(buffer, buffer_seek_start, 0)
	buffer_write(buffer,buffer_text,str)
	
	network_send_raw(global.socket, buffer, buffer_tell(buffer),network_send_text)
}

function create_notification(data) {
	var message = "";
	for (var i = 0; i < array_length(data.data); i++) {
		message += data.data[i];
	}
	instance_create_layer(0,0,"notifications",obj_hint_notification,{title: $"Hint Created!", desc: $"{message}"});
}