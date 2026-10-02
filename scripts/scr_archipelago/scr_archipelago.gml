function send_command(_contents) {
	var arr = [_contents]
	if (struct_exists(_contents,"locations")) {
		if (!is_int64(_contents.locations[0])) {
			_contents.locations = int64(_contents.locations[0]);
		}
	}
	aa = json_stringify(arr)
	show_debug_message(aa);
	
	var buffer = buffer_create(string_byte_length(aa), buffer_fixed,1)
	buffer_seek(buffer, buffer_seek_start, 0)
	buffer_write(buffer,buffer_text,aa)
	
	network_send_raw(global.socket, buffer, buffer_tell(buffer),network_send_text)
}

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