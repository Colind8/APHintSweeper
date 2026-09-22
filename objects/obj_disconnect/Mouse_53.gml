if (!collision_point(mouse_x,mouse_y,self,true,false)) {
	if (instance_exists(obj_network)) {
		image_index = 0;
	} else {
		image_index = 1;
	}
}