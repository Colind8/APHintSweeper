// Inherit the parent event
event_inherited();

text = sample_text;
function on_active() {
	if (text == "") {
		text = sample_text;
	}
	global.current_tab = box_id;
	text = string_digits(text);
	keyboard_string = text;
}
function on_inactive() {
	if (text == "") {
		text = sample_text;
	}
	text = string_digits(text);
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
	if (num > _max) {
		num = _max;
	}
	if (num < minimum) {
		num = minimum;
	}
	text = string(num);
}