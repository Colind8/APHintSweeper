if (!instance_exists(obj_network)) {
	global.socket = network_create_socket(network_socket_ws)
	global.name = ""
	global.server = ""
	global.port = 0
	global.password = ""
	global.deathlink = false;
	
	global.slot_id = -1;
	global.team_id = 0;
	global.game_name = "";
	
	global.secure = false
	global.current_tab = -1;
} else {
	if (obj_network.admin_settings_exist) {
		
	} else {
		layer_set_visible("first_time_setup_notice",true);
		layer_set_visible("first_time",true);
	}
}


function check_admin_settings_exists() {
	
}