if (image_index == 0) {
	return;
}
if (connection_message == "Connecting...") {
	return;
}
if (instance_exists(obj_network)) {
	return;
}

connection_color = c_orange;
connection_message = "Connecting...";

image_index = 0;

with (obj_text_input) {
	if (text == "" && box_id < 2) {
		text = sample_text;
	}
	
	if (box_id == 0) {
		global.server = text;
	}
	if (box_id == 1) {
		global.port = text;
	}
	if (box_id == 2) {
		global.name = text;
	}
	if (box_id == 3) {
		global.password = text;
	}
}

if (global.server == "") {
	connection_color = c_red;
	connection_message = "ERROR: Server IP cannot be empty!";
	return;
}

if (global.port == "") {
	connection_color = c_red;
	connection_message = "ERROR: Server Port cannot be empty!";
	return;
}

if (global.name == "") {
	connection_color = c_red;
	connection_message = "ERROR: Slot name cannot be empty!";
	return; 
}

connection_color = c_orange;
connection_message = "Connecting...";
show_debug_message(connection_message);

instance_create_layer(0,0,"instances",obj_network);