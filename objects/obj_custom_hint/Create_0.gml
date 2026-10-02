teamid = -1;
slotid = -1;

if (type == 0) {
	obj_network.info_context = "custom_location";

	send_command({
		cmd: "GetDataPackage",
		games: [global.game_name]
	});
} else if (type == 1) {
	obj_network.info_context = "custom_item";

	send_command({
		cmd: "Get",
		keys: [
			"APHintSweeper_spoiler"
		]
	});
}


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
		if (type == 0) {
			send_command({
				cmd: "CreateHints",
				locations: [int64(loc_id)],
			});
		}
		global.hint_tokens--;
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Hint Created!", desc: "View your Hint in the Hints tab!"});
	}
	instance_destroy();
}

/// @desc Gets the location names of all items matching the name
/// @param {array} data Spoiler Array
function find_item_by_name(data) {
	var item_index = -1;
	var item_collection = [];
	var game_collection = [];
	
	// Searches through the entire spoiler array, adding each matching index to the item collection array
	// Also adds each unique player to the game collection array
	for (var i = 0; i < array_length(data); i++) {
		show_debug_message($"Reading {i}/{array_length(data)}\n{data[i].ite} == {name}: {data[i].ite == name}")
		if (data[i].ite == name) {
			show_debug_message($"Item found at {i}");
			item_index = i;
			array_push(item_collection,i);
			if (!array_contains(game_collection,data[i].loc_plr)) {
				array_push(game_collection,data[i].loc_plr);
			}
		}
	}
	if (array_length(item_collection) == 0) {
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Error", desc: "Item not found!"});
		instance_destroy();
		return;
	}
	var games_array = [];
	
	// Checks each player and adds their game to games array if they are in the game collection array
	for (var i = 0; i < struct_names_count(global.connection_info.slot_info); i++) {
		if (array_contains(game_collection,struct_get(global.connection_info.slot_info,$"{i + 1}").name)) {
			array_push(games_array,struct_get(global.connection_info.slot_info,$"{i + 1}").game);
		}
	}
	
	//
	for (var i = 0; i < array_length(global.connection_info.players); i++) {
		if (global.connection_info.players[i].name == data[item_index].loc_plr) {
			slotid = global.connection_info.players[i].slot;
			teamid = global.connection_info.players[i].team;
		}
	}
	 
	/*
	show_debug_message(struct_names_count(global.connection_info.slot_info));
	for (var i = 0; i < struct_names_count(global.connection_info.slot_info); i++) {
		if (struct_get(global.connection_info.slot_info,$"{i + 1}").name == data[item_index].loc_plr) {
			game = struct_get(global.connection_info.slot_info,$"{i + 1}").game;
		}
	}
	for (var i = 0; i < array_length(global.connection_info.players); i++) {
		if (global.connection_info.players[i].name == data[item_index].loc_plr) {
			slotid = global.connection_info.players[i].slot;
			teamid = global.connection_info.players[i].team;
		}
	}
	show_debug_message(name);
	show_debug_message(slotid);
	name = data[item_index].loc;
	show_debug_message(name);
	show_debug_message(game);
	obj_network.info_context = "custom_item";

	send_command({
		cmd: "GetDataPackage",
		games: [game]
	});*/
}

function find_item_by_name_2(data) {
	var struct_names = struct_get_names(data);
	var game_struct = struct_get(data,struct_names[0]);
	var location_id = struct_get(game_struct.location_name_to_id,name);
	show_debug_message(location_id);
	obj_network.info_context = $"checking_hint_exists:/:{location_id}";
	send_command({
		cmd: "Get",
		keys: [
			$"_read_hints_{teamid}_{slotid}"
		]
	})
}