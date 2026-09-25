image_index = 0;

var length = array_length(obj_am_login.temp_admin_settings.difficulties);

array_push(obj_am_login.temp_admin_settings.difficulties,{
	index: length,
	name: "Unnamed",
	width: 9,
	height: 9,
	mines: 10,
	timed: false,
	time: 120,
	reward_weights: {
		none: 1,
		filler_loc: 0,
		filler_ite: 0,
		useful_loc: 0,
		useful_ite: 0,
		progre_loc: 0,
		progre_ite: 0,
		hint_token: 0
	}
});
instance_create_layer(
	x,
	y + ((length + 1) * 32), 
	"settings", 
	obj_am_difficultytab,
	{
		index: length
	}
);