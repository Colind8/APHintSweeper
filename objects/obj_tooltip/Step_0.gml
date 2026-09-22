x = mouse_x;
y = mouse_y;

if (!collision_point(mouse_x,mouse_y,inst,true,true)) {
	inst.tooltip_cooldown = 60;
	instance_destroy();
}