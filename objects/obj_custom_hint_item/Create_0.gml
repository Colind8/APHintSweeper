game_collection = []; // list of location players objects containing name, game, slotid, and teamid
item_collection = []; // Holds structs containing the location and loc_player of each item
games_array = [];  // list of all games
game_index = 0; //
package = {};

layer_set_visible("item_hint",false);
layer_set_visible("default",false);
layer_set_visible("hint_processing",true);

obj_network.info_context = "custom_item";

send_command({
	cmd: "Get",
	keys: [
		"APHintSweeper_spoiler"
	]
});

/// @desc Gets the location names of all items matching the name
/// @param {array} data Spoiler Array
function find_item_by_name(data) {
	var player_list = [];
	// Searches through the entire spoiler array, adding each matching index to the item collection array
	// Also adds each unique player to the game collection array
	for (var i = 0; i < array_length(data); i++) {
		show_debug_message($"Reading {i}/{array_length(data)}\n{data[i].ite} == {name}: {data[i].ite == name}")
		if (data[i].ite == name) {
			show_debug_message($"Item found at {i}");
			array_push(item_collection,{
				loc: data[i].loc,
				plr: data[i].loc_plr
			});
			if (!array_contains(player_list,data[i].loc_plr)) {
				array_push(player_list,data[i].loc_plr);
			}
		}
	}
	if (array_length(item_collection) == 0) {
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Error", desc: "Item not found!"});
		layer_set_visible("item_hint",true);
		layer_set_visible("default",true);
		layer_set_visible("hint_processing",false);
		instance_destroy();
		return;
	}
	
	// Checks each player and adds their game to games array if they are in the game collection array
	// Also adds a struct to game collection array containing their name and game
	for (var i = 0; i < struct_names_count(global.connection_info.slot_info); i++) {
		if (array_contains(player_list,struct_get(global.connection_info.slot_info,$"{i + 1}").name)) {
			array_push(game_collection,{
				id: i + 1,
				name: struct_get(global.connection_info.slot_info,$"{i + 1}").name,
				game: struct_get(global.connection_info.slot_info,$"{i + 1}").game,
				slot: -1,
				team: -1,
				locations: []
			});
			array_push(games_array,struct_get(global.connection_info.slot_info,$"{i + 1}").game);
		}
	}
	
	//Adds the slotID and teamID of the user to their struct.
	for (var i = 0; i < array_length(global.connection_info.players); i++) {
		if (array_contains(player_list,global.connection_info.players[i].name)) {
			for (var j = 0; j < array_length(game_collection); j++) {
				if (game_collection[j].name == global.connection_info.players[i].name) {
					game_collection[j].slot = global.connection_info.players[i].slot;
					game_collection[j].team = global.connection_info.players[i].team;
					break;
				}
			}
			
		}
	}
	
	show_debug_message("====Game Collection====:");
	show_debug_message(game_collection);
	show_debug_message("\n");
	 
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
	show_debug_message(game);*/
	obj_network.info_context = "custom_item";

	send_command({
		cmd: "GetDataPackage",
		games: games_array
	});
}

/// @desc After receiving the datapackage, ask for the player's hint list
/// @param {any*} data DataPackage of all games
function find_item_by_name_2(data) {
	package = data;
	var struct_names = struct_get_names(package);
	
	for(var i = 0; i < array_length(struct_names); i++) { // for each game
		var current_player = -1
		var game_struct = struct_get(package,struct_names[i]);
		for (var j = 0; j < array_length(game_collection); j++) {
			if (game_collection[j].game == struct_names[i]) {
				current_player = j
			}
		}
		show_debug_message($"Adding locations of {game_collection[current_player].name}'s {game_collection[current_player].game}");
		
		for (var j = 0; j < array_length(item_collection); j++) { // go through each item
			if (item_collection[j].plr == game_collection[current_player].name) { // push every location id to the resepective player's locations array
				var locid = struct_get(game_struct.location_name_to_id,item_collection[j].loc);
				show_debug_message($"  Pushing: {locid}, {item_collection[j].loc}");
				array_push(game_collection[current_player].locations,locid);
			}
		}
	}
	
	show_debug_message($"== Done with that, getting hints ==");
	obj_network.info_context = "chi_gethints";
	send_command({
		cmd: "Get",
		keys: [
			$"_read_hints_{global.team_id}_{global.slot_id}"
		]
	})
}

/// @desc Goes through each saved location id until it finds one that isn't on the hint list
/// @param {any*} _hints Hint List
function find_item_3(_hints) {
	show_debug_message($"\n\n");
	var no_items = true;
	var player_index = -1;
	var location_index = -1;
	
	game_collection = array_shuffle(game_collection);
	
	for (var i = 0; i < array_length(game_collection); i++) { // for each player
		var hint_found = false;
		show_debug_message($"Searching player {game_collection[i].name}");
		
		for (var j = 0; j < array_length(game_collection[i].locations); j++) { // for each location
			var has_hint = false;
			show_debug_message($"  Checking location {game_collection[i].locations[j]}");
			for (var k = 0; k < array_length(_hints); k++) { // for each hint
				if (_hints[k].finding_player == game_collection[i].id) {
					if (_hints[k].location == game_collection[i].locations[j]) { // if this location already has a hint
						show_debug_message($"Hint found, moving to next item");
						has_hint = true;
						break;
					}
				}
			}
			if (has_hint) { // hint was found, move onto next location
				continue;
			} else { // hint doesn't already exist, save info and bail
				show_debug_message($"Hint does not already exist, will now use this location");
				player_index = i;
				location_index = j;
				hint_found = true;
				break;
			}
		}
		if (hint_found == true) {
			no_items = false;
			break;
		}
	}
	if (no_items) {
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Error", desc: "You already have that hint!"});
	} else {
		show_debug_message($"\n\nCREATING HINT at {game_collection[player_index].locations[location_index]} in {game_collection[player_index].name}'s game ({game_collection[player_index].id})");
		var location_id = game_collection[player_index].locations[location_index];
		var playerid = game_collection[player_index].id;
		if (is_int64(int64(location_id))) {
			show_debug_message(int64(location_id));
			show_debug_message("Location ID is 64bit int");
		}
		if (is_int64(int64(playerid))) {
			show_debug_message(int64(playerid));
			show_debug_message("Player ID is 64bit int");
		}
		send_hint(location_id,playerid);
		global.hint_tokens--;
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Hint Created!", desc: "View your Hint in the Hints tab!"});
	}
	layer_set_visible("item_hint",true);
	layer_set_visible("default",true);
	layer_set_visible("hint_processing",false);
	instance_destroy();
}