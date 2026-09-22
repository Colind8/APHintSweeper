if (!collision_point(mouse_x,mouse_y,self,true,false)) {
	active = false;
	global.current_tab = -1;
	on_inactive();
}