if (image_index == 0) {
	return;
}
if (!instance_exists(obj_network)) {
	return;
}

obj_connect.connection_color = c_black;
obj_connect.connection_message = "Disconnected.";
obj_input_parent.disabled = false;

image_index = 1;
obj_connect.image_index = 0;
network_destroy(global.socket);
instance_destroy(obj_network);
layer_set_visible("first_time_setup_notice",false);
layer_set_visible("first_time",false);
layer_set_visible("main_menu",false);
