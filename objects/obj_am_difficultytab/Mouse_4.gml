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
active = true;
image_index = 1;
if (!layer_get_visible("difficulty_customization")) {
	layer_set_visible("difficulty_customization",true);
	layer_set_visible("difficulty_customization_assets",true);
}


with (obj_input_parent) {
	switch (box_id) {
		case 1:
			text = obj_am_login.temp_admin_settings.difficulties[other.index].name;
			break;
		case 2:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].width);
			break;
		case 3:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].height);
			break;
		case 4:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].mines);
			break;
		case 5:
			checked = bool(obj_am_login.temp_admin_settings.difficulties[other.index].timed);
			break;
		case 6:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].time);
			break;
		case 7:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.none);
			break;
		case 8:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.filler_loc);
			break;
		case 9:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.useful_loc);
			break;
		case 10:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.progre_loc);
			break;
		case 11:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.filler_ite);
			break;
		case 12:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.useful_ite);
			break;
		case 13:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.progre_ite);
			break;
		case 14:
			text = string(obj_am_login.temp_admin_settings.difficulties[other.index].reward_weights.hint_token);
			break;
		
	}
}