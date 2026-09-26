// Inherit the parent event
event_inherited();

login_info = "";
admin_loggedin = false;
message_color = c_black;
login_message = "Logged out.";
temp_admin_settings = {
	ver: 1,
	item_hints: false,
	difficulties: []
}
temp_spoiler = [];

function on_click() {
	if (admin_loggedin) {
		return;
	}
	with (obj_input_parent) {
		if (box_id == 0) {
			obj_am_login.login_info = text;
		}
	}
	
	obj_network.info_context = "admin_login";
	send_command({cmd: "Say", text: $"!admin login {login_info}"});
}

function save_difficulty() {
	with (obj_am_difficultytab) {
		if (active) {
			with (obj_input_parent) {
				switch (box_id) {
					case 1:
						obj_am_login.temp_admin_settings.difficulties[other.index].name = text;
						break;
					case 2:
						obj_am_login.temp_admin_settings.difficulties[other.index].width = int64(text);
						break;
					case 3:
						obj_am_login.temp_admin_settings.difficulties[other.index].height = int64(text);
						break;
					case 4: 
						obj_am_login.temp_admin_settings.difficulties[other.index].mines = int64(text);
						break;
					case 5:
						obj_am_login.temp_admin_settings.difficulties[other.index].timed = bool(checked);
						break;
					case 6:
						obj_am_login.temp_admin_settings.difficulties[other.index].time = int64(text);
						break;
					case 7:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.none = int64(text);
						break;
					case 8:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.filler_loc = int64(text);
						break;
					case 9:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.useful_loc = int64(text);
						break;
					case 10:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.progre_loc = int64(text);
						break;
					case 11:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.filler_ite = int64(text);
						break;
					case 12:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.useful_ite = int64(text);
						break;
					case 13:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.progre_ite = int64(text);
						break;
					case 14:
						obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.hint_token = int64(text);
						break;
				}
			}
		}
		active = false;
		image_index = 0;
	}
	var w = obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights;
	if ((w.none + w.filler_loc + w.useful_loc + w.progre_loc + w.filler_ite + w.useful_ite + w.progre_ite + w.hint_token) == 0) {
		obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.none = 1;
	}
}

function load_difficulties() {
	layer_set_visible("difficulty_customization",false);
	layer_set_visible("difficulty_customization_assets",false);
	if (instance_exists(obj_am_difficultytab)) {
		instance_destroy(obj_am_difficultytab);
	}
	for (var i = 0; i < array_length(temp_admin_settings.difficulties); i++) {
		instance_create_layer(
			obj_am_creatediff.x,
			obj_am_creatediff.y + ((i + 1) * 32), 
			"settings", 
			obj_am_difficultytab,
			{
				index: i
			}
		);
	}
}