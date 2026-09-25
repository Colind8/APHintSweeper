// Inherit the parent event
event_inherited();

login_info = "";
admin_loggedin = false;
message_color = c_black;
login_message = "Logged out.";

function on_click() {
	if (admin_loggedin) {
		return;
	}
	with (obj_input_parent) {
		if (box_id == 0) {
			obj_am_login.login_info = text;
		}
	}
	
	obj_network.info_context = "admin_login";
	send_command({cmd: "Say", text: $"!admin login {login_info}"});
}