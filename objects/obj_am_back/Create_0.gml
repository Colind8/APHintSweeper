// Inherit the parent event
event_inherited();

function on_click() {
	if (obj_am_login.admin_loggedin) {
		send_command({cmd: "Say", text: $"!admin logout"});
	}
	room_goto(rm_login);
}