// Inherit the parent event
event_inherited();

function on_click() {
	disabled = true;
	send_command({
		cmd: "Set",
		key: "APHintSweeper_settings",
		want_reply: true,
		operations: [
			{
				operation: "replace",
				value: obj_am_login.temp_admin_settings
			}
		]
	});
}