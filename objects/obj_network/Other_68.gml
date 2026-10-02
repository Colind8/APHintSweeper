///@desc Buffer loading & Receiving Items

//Loads the buffers and lists them out into a variable (Probably not useful for the most part, just there at this point for assurance.)
var type = async_load[? "type"];

//show_debug_message(type);

if (type == network_type_up_failed) {
	show_debug_message("Connection failure");
	
}

if(async_load[? "size"] > 0){
	var buff = async_load[? "buffer"];
	buffer_seek(buff,buffer_seek_start,0);
	var response = buffer_read(buff,buffer_string)
}
buffer_seek(buff,buffer_seek_start,0)
var data = json_parse(response)

//Locks the data needed for the next functions into an array.
for (var i = 0; i < array_length(data); ++i) {
	//Note: struct_exists() was added in v2023.8.x.xx, versions prior will need to be optimized to account for this.
	if struct_exists(data[i], "cmd") {
		//show_debug_message(data[i].cmd)
		
		if (data[i].cmd == "Connected") {
			show_debug_message(data[i]);
			obj_connect.connection_color = c_green;
			obj_connect.connection_message = "Connected!"
			obj_input_parent.disabled = true;
			obj_connect.image_index = 1;
			obj_disconnect.image_index = 0;
			global.slot_id = data[i].slot;
			global.team_id = data[i].team;
			global.connection_info = data[i];
			global.game_name = struct_get(data[i].slot_info,$"{global.slot_id}").game;
			show_debug_message($"\nTeam: {string(global.team_id)}\nSlot: {string(global.slot_id)}");
			
			info_context = "admin_settings_exist";
			send_command({
				cmd: "Get",
				keys: ["APHintSweeper_settings"]
			});
		}
		if (data[i].cmd == "DataPackage") {
			switch (info_context) {
				case "custom_location":
					obj_custom_hint.find_location_from_name(data[i].data.games);
					break;
				case "custom_item":
					obj_custom_hint_item.find_item_by_name_2(data[i].data.games);
					break;
			}
		}
		if (data[i].cmd == "Retrieved") {
			show_debug_message(data[i]);
			var info_context_arr = string_split(info_context,":/:");
			var st_na = struct_get_names(data[i].keys);
			switch (info_context_arr[0]) {
				case "admin_settings_exist":
					if (data[i].keys.APHintSweeper_settings == undefined) {
						admin_settings_exist = false;
						layer_set_visible("first_time_setup_notice",true);
						layer_set_visible("first_time",true);
					} else {
						admin_settings_exist = true;
						admin_settings = data[i].keys.APHintSweeper_settings;
						show_debug_message(admin_settings);
						show_debug_message("Setting main_menu visible");
						layer_set_visible("main_menu",true);
					}
					break;
				case "checking_hint_exists":
					obj_custom_hint.hint_exists(struct_get(data[i].keys,st_na[0]),info_context_arr[1]);
					break;
				case "custom_item":
					show_debug_message("custom item");
					obj_custom_hint_item.find_item_by_name(data[i].keys.APHintSweeper_spoiler);
					break;
				case "chi_gethints":
					obj_custom_hint_item.find_item_3(struct_get(data[i].keys,st_na[0]));
					break;
			}
		}
		if (data[i].cmd == "ConnectionRefused") {
			show_debug_message(data[i]);
			obj_connect.connection_color = c_red;
			if (data[i].errors[0] == "InvalidSlot") {
				obj_connect.connection_message = "ERROR: Invalid Slot name.";
			}
			if (data[i].errors[0] == "InvalidPassword") {
				obj_connect.connection_message = "ERROR: Invalid password.";
			}
			
			network_destroy(global.socket);
			instance_destroy();
		}
		if (data[i].cmd == "PrintJSON") {
			if (struct_exists(data[i],"type")) {
				if (data[i].type == "CommandResult") {
					if (data[i].data[0].text == "Login successful. You can now issue server side commands.") {
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "Logged in!"
						obj_am_login.message_color = c_green;
						obj_am_login.admin_loggedin = true;
						obj_am_login.disabled = true;
						with (obj_input_parent) {
							if (box_id == 0) {
								disabled = true;
							}
						}
						layer_set_visible("settings",true);
						if (!admin_settings_exist) {
							obj_am_login.temp_admin_settings = {
								ver: 1,
								item_hints: false,
								difficulties: []
							}
						} else {
							obj_am_login.temp_admin_settings = admin_settings;
							if (obj_am_login.temp_admin_settings.item_hints) {
								instance_destroy(obj_am_import_spoiler);
							}
							obj_am_login.load_difficulties();
						}
					} else if (data[i].data[0].text == "Logout successful. You can no longer issue server side commands."){
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "Logged out."
						obj_am_login.message_color = c_black;
						obj_am_login.admin_loggedin = false;
						layer_set_visible("settings",false);
					} else if (data[i].data[0].text == "Password incorrect.") {
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "ERROR: Incorrect password!"
						obj_am_login.message_color = c_red;
						obj_am_login.admin_loggedin = false;
					} else if (data[i].data[0].text == "Sorry, Remote administration is disabled") {
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "ERROR: Remote Administration is disabled!"
						obj_am_login.message_color = c_red;
						obj_am_login.admin_loggedin = false;
					} else {
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "ERROR: Unknown!"
						obj_am_login.message_color = c_red;
						obj_am_login.admin_loggedin = false;
					}
				}
			}  
		}
		if (data[i].cmd == "SetReply") {
			if (data[i].key == "APHintSweeper_settings") {
				show_debug_message("APHintSweeper_settings set!");
				if (array_length(obj_am_login.temp_spoiler) > 0) {
					show_debug_message("Now setting APHintSweeper_spoiler...");
					send_command({
						cmd: "Set",
						key: "APHintSweeper_spoiler",
						want_reply: true,
						operations: [
							{
								operation: "replace",
								value: obj_am_login.temp_spoiler
							}
						]
					});
				} else {
					send_command({cmd: "Say", text: $"!admin logout"});
					room_goto(rm_login);
				}
			}
			if (data[i].key == "APHintSweeper_spoiler") {
				show_debug_message("APHintSweeper_spoiler set!");
				send_command({cmd: "Say", text: $"!admin logout"});
				room_goto(rm_login);
			}
		}
	}
}

