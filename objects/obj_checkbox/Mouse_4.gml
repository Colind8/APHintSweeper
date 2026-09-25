// Inherit the parent event
if (instance_exists(obj_network) && (room == rm_login)) {
	return;
}
checked = !checked;
event_inherited();
