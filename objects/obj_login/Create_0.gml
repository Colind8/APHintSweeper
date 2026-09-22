if (!instance_exists(obj_network)) {
	global.socket = network_create_socket(network_socket_ws)
	global.name = ""
	global.server = ""
	global.port = 0
	global.password = ""
	global.deathlink = false;
	
	global.slot_id = -1;
	global.team_id = 0;
	
	global.secure = false
	global.current_tab = -1;
} else {
	if (obj_network.admin_settings_exist) {
		
	} else {
		layer_set_visible("first_time_setup_notice",true);
		instance_create_layer(704,295,"instances",obj_admin_panel_button);
	}
}


function check_admin_settings_exists() {
	
}