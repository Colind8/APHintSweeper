if (!obj_am_login.admin_loggedin) {
	return;
}

obj_am_login.save_difficulty();
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