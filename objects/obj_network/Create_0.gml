///@description Network connection data
global.slot_id = -1;
global.team_id = 0;
global.hint_tokens = 0;

global.secure = false

admin_settings_exist = false;
admin_settings = {};
info_context = ""; // The context of a Get

if global.server = "archipelago.gg" {
		global.secure = true
} else { global.secure = false }

APgame = "" //Change this to whatever your game is, you shouldn't need to change it more than once.

//Maybe you can optimize this better? it works already for what it needs to be.
wss = network_socket_wss
ws = network_socket_ws


if global.secure = true && global.socket != network_create_socket(wss) {
		global.socket = network_create_socket(wss)
}
if global.secure = false && global.socket != network_create_socket(ws) {
	global.socket = network_create_socket(ws)	
}


playerSent = 0

item = 0
var tag_array = ["HintGame"];
if (global.deathlink) {
	array_push(tag_array,"DeathLink");
}

//JSON file contents
var _contents = {
		cmd: "Connect",
		password: global.password,
		game: APgame,
		name: global.name,
		uuid: int64(999999),
		items_handling: int64(0),
		tags: tag_array,
		version : {
			build : int64(0),
			class: "Version",
			minor: int64(7),
			major: int64(0)
	}
}

var arr = [ _contents] // adds the brackets to the json as needed by AP
aa = json_stringify(arr)

//Connect to the server, adds the buffers and the json as needed.
isConnected = network_connect_raw(global.socket, global.server, global.port)
show_debug_message(isConnected);
if (isConnected == -1) {
	show_debug_message("Connection failure");
	obj_connect.connection_color = c_red;
	obj_connect.connection_message = "ERROR: Failed to connect. Make sure Server IP and Port is correct!"
	network_destroy(global.socket);
	instance_destroy();
} else {
	buffer = buffer_create(string_byte_length(aa), buffer_fixed,1)
	buffer_seek(buffer, buffer_seek_start, 0)
	buffer_write(buffer,buffer_text,aa)
	
	//Sends the json to the server. If you can make this better I applaud you.
	network_send_raw(global.socket, buffer, buffer_tell(buffer),network_send_text)
}