// Inherit the parent event
event_inherited();

depth = depth - 1;

function on_click() {
	instance_destroy(obj_hint_notification);
	instance_destroy(obj_tooltip);
	instance_destroy();
}