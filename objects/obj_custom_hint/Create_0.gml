obj_network.info_context = "custom_location";

send_command({
	cmd: "GetDataPackage",
	games: [global.game_name]
});

function find_location_from_name(data) {
	var game_struct = struct_get(data,global.game_name);
	var location_id = struct_get(game_struct.location_name_to_id,name);
	show_debug_message(location_id);
	obj_network.info_context = $"checking_hint_exists:/:{location_id}";
	send_command({
		cmd: "Get",
		keys: [
			$"_read_hints_{global.team_id}_{global.slot_id}"
		]
	})
}

function hint_exists(data,loc_id) {
	var exists = false;
	for (var i = 0; i < array_length(data); i++) {
		if (data[i].location == loc_id) {
			exists = true;
			break;
		}
	}
	
	show_debug_message(exists);
	
	if (exists) {
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Error", desc: "You already have that hint!"});
	} else if (loc_id == "undefined") {
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Error", desc: "Location not found!"});
	} else {
		send_command({
			cmd: "CreateHints",
			locations: [int64(loc_id)]
		});
		global.hint_tokens--;
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Hint Created!", desc: "View your Hint in the Hints tab!"});
	}
	instance_destroy();
}