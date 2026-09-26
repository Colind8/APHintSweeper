// Inherit the parent event
event_inherited();

checked = false;

function on_active() {
	global.current_tab = box_id;
	if (checked) {
		image_index = 3;
	} else {
		image_index = 1;
	}
}

function on_inactive() {
	if (checked) {
		image_index = 2;
	} else {
		image_index = 0;
	}
}