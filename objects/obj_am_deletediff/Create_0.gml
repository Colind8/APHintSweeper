// Inherit the parent event
event_inherited();

function on_click() {
	var ind;
	mouse_over = false;
	with (obj_am_difficultytab) {
		if (active) {
			ind = index;
		}
	}
	array_delete(obj_am_login.temp_admin_settings.difficulties,ind,1);
	obj_am_login.load_difficulties();
}