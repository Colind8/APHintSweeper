// Inherit the parent event
event_inherited();

function on_click() {
	var time = -1;
	if (obj_network.admin_settings.difficulties[index].timed == true) {
		time = obj_network.admin_settings.difficulties[index].time;
	}
	
	instance_create_layer(0,0,"instances",obj_gs_trans,{
		w: obj_network.admin_settings.difficulties[index].width,
		h: obj_network.admin_settings.difficulties[index].height,
		m: obj_network.admin_settings.difficulties[index].mines,
		t: time,
		i: index
	});
};