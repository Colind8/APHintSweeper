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
			obj_connect.image_index = 1;
			obj_disconnect.image_index = 0;
			global.slot_id = data[i].slot;
			global.team_id = data[i].team;
			show_debug_message($"\nTeam: {string(global.team_id)}\nSlot: {string(global.slot_id)}");
			
			info_context = "admin_settings_exist";
			send_command({
				cmd: "Get",
				keys: ["APHintSweeper_settings"]
			});
		}
		if (data[i].cmd == "DataPackage") {
			show_debug_message(data[i]);
		}
		if (data[i].cmd == "Retrieved") {
			show_debug_message(data[i]);
			switch (info_context) {
				case "admin_settings_exist":
					if (data[i].keys.APHintSweeper_settings == undefined) {
						admin_settings_exist = false;
						layer_set_visible("first_time_setup_notice",true);
						instance_create_layer(704,295,"instances",obj_admin_panel_button);
					} else {
						admin_settings_exist = true;
					}
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
			//show_debug_message(data[i]);
			if (struct_exists(data[i],"type")) {
				//show_debug_message("type exists");
				if (data[i].type == "CommandResult") {
					//show_debug_message("type is CommandResult");
					if (data[i].data[0].text == "Login successful. You can now issue server side commands.") {
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "Logged in!"
						obj_am_login.message_color = c_green;
						obj_am_login.admin_loggedin = true;
					} else if (data[i].data[0].text == "Logout successful. You can no longer issue server side commands."){
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "Logged out."
						obj_am_login.message_color = c_black;
						obj_am_login.admin_loggedin = false;
					} else {
						if (!instance_exists(obj_am_login)) {
							return;
						}
						obj_am_login.login_message = "Incorrect password!"
						obj_am_login.message_color = c_red;
						obj_am_login.admin_loggedin = false;
					}
				}
			}  
		}
	}
}

