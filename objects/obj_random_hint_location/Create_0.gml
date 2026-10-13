obj_network.info_context = "random_location";

image_xscale = 40;
image_yscale = 20;
x = (room_width/2) - (sprite_width / 2);
y = (room_height/2) - (sprite_height / 2);

/*send_command({
	cmd: "GetDataPackage",
	games: [global.game_name]
});*/

location_ids = [];
location_objects = [];
playerid = -1;
flag_name = "";

switch (flag) {
	case 0:
		flag_name = "Filler/Trap";
		break;
	case 1:
		flag_name = "Progression";
		break;
	case 2:
		flag_name = "Useful";
		break;
	case 4:
		flag_name = "Trap";
}

for (var i = 0; i < struct_names_count(global.connection_info.slot_info); i++) {
	if (struct_get(global.connection_info.slot_info,$"{i + 1}").name == global.name) {
		playerid = i + 1;
	}
}

for (var i = 0; i < array_length(global.connection_info.missing_locations); i++) {
	array_push(location_ids,int64(global.connection_info.missing_locations[i]));
}

send_command({
	cmd: "LocationScouts",
	locations: location_ids,
	create_as_hint: int64(0)
});

function randhintloc(data) {
	for (var i = 0; i < array_length(data); i++) {
		if (flag == 0) {
			if (data[i].flags == 0 || (data[i].flags == 4)) {
				array_push(location_objects,data[i]);
			}
		} else {
			if (data[i].flags == flag) {
				array_push(location_objects,data[i]);
			}
		}
		
	}
	
	array_shuffle(location_objects);
	send_command({
		cmd: "Get",
		keys: [
			$"_read_hints_{global.team_id}_{global.slot_id}"
		]
	})
}

function randhintloc_2(hints) {
	var found = false; // searching for if a hint doesn't exist
	var hint_index = -1;
	for (var i = 0; i < array_length(location_objects); i++) {
		var hint_exists = false;
		for (var k = 0; k < array_length(hints); k++) { 
			if (hints[k].finding_player == playerid) {
				if (location_objects[i].location == hints[k].location) {
					hint_exists = true;
					break;
				}
			}
			
		}
		if (hint_exists) {
			continue;
		} else {
			found = true;
			hint_index = i;
			break;
		}
	}
	if (!found) {
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: $"{flag_name} Item!", desc: "Unfortunately you've already found every location of that item type, so you won nothing!"});
	} else {
		send_hint(location_objects[hint_index].location,playerid);
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: $"{flag_name} Item!", desc: "View your hint in the hints tab!"});
		instance_destroy();
	}
}