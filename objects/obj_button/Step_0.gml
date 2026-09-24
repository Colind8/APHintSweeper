if (mouse_over && (tooltip_text != "")) {
	if (tooltip_cooldown <= 0) {
		if (!instance_exists(obj_tooltip)) {
			instance_create_depth(x,y,-10000,obj_tooltip,{text: tooltip_text,inst: id});
		}
	} else {
		tooltip_cooldown--;
	}
}
if(mouse_over) {
	if (mouse_check_button(mb_left)) {
		image_index = 1;
	} else {
		image_index = 0;
	}
}

if (mouse_over) {
	if (mouse_check_button_released(mb_left)) {
		on_click();
	}
}