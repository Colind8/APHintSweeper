if (keyboard_check_pressed(vk_escape) && active) {
	active = false;
	global.current_tab = -1;
}

if (keyboard_check_direct(vk_shift) && (active)) {
	if (keyboard_check_pressed(vk_tab)) {
		global.current_tab = tab_from;
		show_debug_message(global.current_tab);
		with (obj_input_parent) {
			active = false;
			on_inactive();
			if (box_id == global.current_tab) {
				keyboard_clear(vk_tab);
				active = true;
				on_active();
			}
		}
	}
}

if (keyboard_check_pressed(vk_tab)) {
	if (!active) {
		if (global.current_tab == -1) {
			if (box_id == 0) {
				keyboard_clear(vk_tab);
				active = true;
				on_active();
			}
		}
	} else {
		global.current_tab = tab_to;
		with (obj_input_parent) {
			active = false;
			on_inactive();
			if (box_id == global.current_tab) {
				keyboard_clear(vk_tab);
				active = true;
				on_active();
			}
		}
	}
	
}
