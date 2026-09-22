// Inherit the parent event
event_inherited();

checked = false;

function on_active() {
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