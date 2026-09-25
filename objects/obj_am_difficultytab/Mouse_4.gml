with (obj_am_difficultytab) {
	if (active) {
		with (obj_input_parent) {
			if (box_id == 1) {
				obj_am_login.temp_admin_settings.difficulties[other.index].name = text;
			}
			if (box_id == 2) {
				obj_am_login.temp_admin_settings.difficulties[other.index].width = int64(text);
			}
			if (box_id == 3) {
				obj_am_login.temp_admin_settings.difficulties[other.index].height = int64(text);
			}
			if (box_id == 4) {
				obj_am_login.temp_admin_settings.difficulties[other.index].mines = int64(text);
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
	if (box_id == 1) {
		text = obj_am_login.temp_admin_settings.difficulties[other.index].name;
	}
	if (box_id == 2) {
		text = string(obj_am_login.temp_admin_settings.difficulties[other.index].width);
	}
	if (box_id == 3) {
		text = string(obj_am_login.temp_admin_settings.difficulties[other.index].height);
	}
	if (box_id == 4) {
		text = string(obj_am_login.temp_admin_settings.difficulties[other.index].mines);
	}
}