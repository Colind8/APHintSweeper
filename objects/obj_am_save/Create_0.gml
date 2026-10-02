// Inherit the parent event
event_inherited();

function on_click() {
	save();
	disabled = true;
	send_command({
		cmd: "Set",
		key: "APHintSweeper_settings",
		want_reply: true,
		operations: [
			{
				operation: "replace",
				value: obj_am_login.temp_admin_settings
			}
		]
	});
}

function save() {
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
			var w = obj_am_login.temp_admin_settings.difficulties[index].reward_weights;
			if ((w.none + w.filler_loc + w.useful_loc + w.progre_loc + w.filler_ite + w.useful_ite + w.progre_ite + w.hint_token) == 0) {
				obj_am_login.temp_admin_settings.difficulties[index].reward_weights.none = 1;
			}
		}
		active = false;
		image_index = 0;
	}
	
}