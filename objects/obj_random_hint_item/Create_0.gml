obj_network.info_context = "random_item";

image_xscale = 40;
image_yscale = 20;
x = (room_width/2) - (sprite_width / 2);
y = (room_height/2) - (sprite_height / 2);

key_amount = "?";
playerid = -1;
collection = [];
game_collection = [];
games_array = [];
package = {}

for (var i = 0; i < struct_names_count(global.connection_info.slot_info); i++) {
	if (struct_get(global.connection_info.slot_info,$"{i + 1}").name == global.name) {
		playerid = i + 1;
	}
}

for (var i = 0; i < array_length(obj_network.admin_settings.ihkt); i++) {
	var _split = string_split(obj_network.admin_settings.ihkt[i],"_");
	if (_split[0] == string(playerid)) {
		key_amount = _split[1];
		break;
	}
}

send_command({
	cmd: "Get",
	keys: [
		$"APHintSweeper_spoiler_{playerid}_1_{key_amount}"
	]
});

function build_item_array(data,a,b) {
	collection = array_union(collection,data);
	_a = int64(a);
	show_debug_message($"\na == b: {a == b}")
	if (a == b) {
		pick_random_item();
	} else {
		send_command({
			cmd: "Get",
			keys: [
				$"APHintSweeper_spoiler_{playerid}_{_a + 1}_{b}"
			]
		});
	}
}

function pick_random_item() {
	var filtered_collection = [];
	var player_list = [];
	for (var i = 0; i < array_length(collection); i++) {
		if (collection[i].ite_plr == global.name) {
			array_push(filtered_collection,collection[i]);
			if (!array_contains(player_list,collection[i].loc_plr)) {
				array_push(player_list,collection[i].loc_plr);
			}
		}
	}
	collection = array_shuffle(filtered_collection);
	
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
	
	send_command({
		cmd: "GetDataPackage",
		games: games_array
	});
}

function pick_random_item_2(data) {
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
		
		for (var j = 0; j < array_length(collection); j++) { // go through each item
			if (collection[j].loc_plr == game_collection[current_player].name) { // push every location id to the resepective player's locations array
				var locid = struct_get(game_struct.location_name_to_id,collection[j].loc);
				show_debug_message($"  Pushing: {locid}, {collection[j].loc}");
				array_push(game_collection[current_player].locations,locid);
			}
		}
	}
	
	show_debug_message($"== Done with that, getting hints ==");
	obj_network.info_context = "ri_gethints";
	send_command({
		cmd: "Get",
		keys: [
			$"_read_hints_{global.team_id}_{global.slot_id}"
		]
	})
}

function pick_random_item_3(_hints) {
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
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Error", desc: "You already have every item hint!"});
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
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Hint Created!", desc: "View your Hint in the Hints tab!"});
	}
	instance_destroy();
}