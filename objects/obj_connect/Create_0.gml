connection_message = "";
connection_color = c_red;

if (instance_exists(obj_network)) {
	connection_color = c_green;
	connection_message = "Connected!";
	with (obj_input_parent) {
		if (box_id == 0) {
			text = global.server;
		}
		if (box_id == 1) {
			text = global.port;
		}
		if (box_id == 2) {
			text = global.name;
		}
		if (box_id == 3) {
			text = global.password;
		}
		if (box_id == 4) {
			checked = global.deathlink;
		}
	}
	image_index = 1;
	
} else {
	connection_color = c_black;
	connection_message = "Disconnected.";
	image_index = 0;
}