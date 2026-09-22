// Inherit the parent event
event_inherited();

if (keyboard_check_pressed(vk_space) && (active)) {
	checked = !checked;
	on_active();
}