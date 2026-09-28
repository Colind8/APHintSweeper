// Inherit the parent event
event_inherited();

function on_click() {
	if (global.hint_tokens == 0) {
		instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "Error", desc: "You need a Hint Token to buy hints!"});
		return;
	}
	
	with (obj_input_parent) {
		if (box_id == 0) {
			instance_create_layer(0,0,"default",obj_custom_hint,{type:0,name: text});
		}
	}
};
