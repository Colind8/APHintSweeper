// Inherit the parent event
event_inherited();

function on_click() {
	if (!obj_am_login.admin_loggedin) {
		return;
	}
	layer_set_visible("importer",true);
	layer_set_visible("login_screen",false);
	layer_set_visible("settings",false);
	layer_set_visible("difficulty_customization",false);
	layer_set_visible("difficulty_customization_assets",false);
	layer_set_visible("assets",false);
	var file;
	file = get_open_filename("text file|*.txt", "Spoiler.txt");
	if (file != "") {
		instance_create_layer(0,0,"importer",obj_spoiler_importer,{file_name: file});
		mouse_over = false;
		disabled = true;
	} else {
		layer_set_visible("importer",false);
		layer_set_visible("login_screen",true);
		layer_set_visible("settings",true);
		layer_set_visible("difficulty_customization",false);
		layer_set_visible("difficulty_customization_assets",false);
		layer_set_visible("assets",true);
	}
}