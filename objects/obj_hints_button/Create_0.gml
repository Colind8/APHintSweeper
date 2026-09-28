// Inherit the parent event
event_inherited();

function on_click() {
	obj_network.info_context = "test";
	show_debug_message($"Getting _read_location_name_groups_{global.game_name}")
	send_command({
		cmd: "GetDataPackage",
		games: [
			$"{global.game_name}"
		]
	})
}
