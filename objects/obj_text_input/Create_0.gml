// Inherit the parent event
event_inherited();

text = "";
function on_active() {
	global.current_tab = box_id;
	keyboard_string = text;
}
function on_inactive() {
	
}