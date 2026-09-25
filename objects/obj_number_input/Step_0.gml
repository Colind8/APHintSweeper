// Inherit the parent event
event_inherited();

if (keyboard_check(vk_anykey) && active) {
	text = keyboard_string;
}

if (active) {
	text = string_digits(text);
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
if (mouse_wheel_up() && active) {
	var num = real(string_digits(text));
	var _max = maximum;
	if (maximum == -1) {
		with (obj_input_parent) {
			if (box_id == 2) {
				_max = real(string_digits(text))
			}
		}
		with (obj_input_parent) {
			if (box_id == 3) {
				_max *= real(string_digits(text))
			}
		}
		_max = floor(_max * 0.40);
	}
	num = floor(num);
	if (num < _max) {
		num++;
	} else {
		num = _max;
	}
	text = string(num);
}
if (mouse_wheel_down() && active) {
	var num = string_digits(text);
	if (num > minimum) {
		num--;
	} else {
		num = minimum;
	}
	text = string(num);
}