// Inherit the parent event
event_inherited();

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