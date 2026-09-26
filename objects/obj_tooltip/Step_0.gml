x = mouse_x;
y = mouse_y;

if (variable_instance_exists(inst,"mouse_over")) {
	if (!inst.mouse_over) {
		inst.tooltip_cooldown = 30;
		instance_destroy();
	}
} else {
	if (!collision_point(mouse_x,mouse_y,inst,true,true)) {
		inst.tooltip_cooldown = 30;
		instance_destroy();
	}
}