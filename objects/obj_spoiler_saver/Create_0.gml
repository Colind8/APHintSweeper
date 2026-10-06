ind = 0; // Current player index
split_ind = 0; // Split index
slot_names = variable_struct_get_names(global.connection_info.slot_info);
temp_arr = [[]]
ihkt = [];

layer_set_visible("importer",true);
layer_set_visible("login_screen",false);
layer_set_visible("settings",false);
layer_set_visible("difficulty_customization",false);
layer_set_visible("difficulty_customization_assets",false);
layer_set_visible("assets",false);

save_player_spoiler();


function save_player_spoiler() {
	temp_arr = [[]];
	split_ind = 0;
	for (var i = 0; i < array_length(obj_am_login.temp_spoiler); i++) {
		if (struct_get(global.connection_info.slot_info,slot_names[ind]).name == obj_am_login.temp_spoiler[i].ite_plr) {
			array_push(temp_arr[array_length(temp_arr) - 1],obj_am_login.temp_spoiler[i]);
			if (array_length(temp_arr[array_length(temp_arr) - 1]) > 600) {
				array_push(temp_arr,[]);
			}
		} 
	}
	show_debug_message("")
	array_push(ihkt,$"{slot_names[ind]}_{array_length(temp_arr)}");
	if (array_length(temp_arr) > 1) {
		send_command({
			cmd: "Set",
			key: $"APHintSweeper_spoiler_{slot_names[ind]}_1_{array_length(temp_arr)}",
			want_reply: true,
			operations: [
				{
					operation: "replace",
					value: temp_arr[0]
				}
			]
		});
	} else {
		send_command({
			cmd: "Set",
			key: $"APHintSweeper_spoiler_{slot_names[ind]}_1_1",
			want_reply: true,
			operations: [
				{
					operation: "replace",
					value: temp_arr[0]
				}
			]
		});
	}
}

function save_spoiler_split() {
	send_command({
		cmd: "Set",
		key: $"APHintSweeper_spoiler_{slot_names[ind]}_{split_ind + 1}_{array_length(temp_arr)}",
		want_reply: true,
		operations: [
			{
				operation: "replace",
				value: temp_arr[split_ind]
			}
		]
	});
}