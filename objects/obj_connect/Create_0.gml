connection_message = "";
connection_color = c_red;

if (instance_exists(obj_network)) {
	connection_color = c_green;
	connection_message = "Connected!";
	obj_input_parent.disabled = true;
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
	if (!obj_network.admin_settings_exist) {
		info_context = "admin_settings_exist";
		send_command({
			cmd: "Get",
			keys: ["APHintSweeper_settings"]
		});
	} else {
		layer_set_visible("main_menu", true);
	}
		
	
} else {
	connection_color = c_black;
	obj_input_parent.disabled = false;
	connection_message = "Disconnected.";
	image_index = 0;
}