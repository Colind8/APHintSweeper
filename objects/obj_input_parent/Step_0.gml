if (keyboard_check_pressed(vk_escape) && active) {
	active = false;
	global.current_tab = -1;
}

if (keyboard_check_direct(vk_shift) && (active)) {
	if (keyboard_check_pressed(vk_tab)) {
		global.current_tab = tab_from;
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
			if ((box_id == 0) && (disabled == false)) {
				keyboard_clear(vk_tab);
				active = true;
				on_active();
			} else if ((box_id == 1) && (disabled == false)) {
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

if (collision_point(mouse_x,mouse_y,self,true,false) && (tooltip_text != "")) {
	if (tooltip_cooldown <= 0) {
		if (!instance_exists(obj_tooltip)) {
			instance_create_depth(x,y,-10000,obj_tooltip,{text: tooltip_text,inst: id});
		}
	} else {
		tooltip_cooldown--;
	}
}