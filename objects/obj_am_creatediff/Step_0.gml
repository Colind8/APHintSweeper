if (!obj_am_login.admin_loggedin) {
	return;
}

if (collision_point(mouse_x,mouse_y,self,true,false) && (tooltip_text != "")) {
	if (tooltip_cooldown <= 0) {
		if (!instance_exists(obj_tooltip)) {
			instance_create_depth(x,y,-10000,obj_tooltip,{text: tooltip_text,inst: id});
		}
	} else {
		tooltip_cooldown--;
	}
}