if (keyboard_check_pressed(vk_enter) && active) {
	active = false;
}

if (keyboard_check(vk_anykey) && active) {
	text = keyboard_string;
}

if ((string_length(text) > max_length) && active) {
	text = string_delete(text,max_length,string_length(text) - max_length);
	show_debug_message(text);
	keyboard_string = text;
}

if (keyboard_check_direct(vk_control) && active) {
	if (keyboard_check_pressed(ord("V"))) {
		text += clipboard_get_text();
		keyboard_string = text;
	}
	if (keyboard_check_pressed(vk_backspace)) {
		text = "";
		keyboard_string = text;
	}
}

if (keyboard_check_direct(vk_shift) && (active)) {
	if (keyboard_check_pressed(vk_tab)) {
		global.current_tab = tab_from;
		show_debug_message(global.current_tab);
		with (obj_text_input) {
			active = false;
			if (box_id == global.current_tab) {
				keyboard_clear(vk_tab);
				active = true;
				keyboard_string = text;
			}
		}
	}
}

if (keyboard_check_pressed(vk_tab) && (active)) {
	global.current_tab = tab_to;
	with (obj_text_input) {
		active = false;
		if (box_id == global.current_tab) {
			keyboard_clear(vk_tab);
			active = true;
			keyboard_string = text;
		}
	}
}