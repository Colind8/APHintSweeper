connection_message = "";
connection_color = c_red;

if (instance_exists(obj_network)) {
	connection_color = c_green;
	connection_message = "Connected!";
} else {
	connection_color = c_black;
	connection_message = "Disconnected.";
}