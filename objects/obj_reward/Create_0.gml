var gs = obj_network.admin_settings.difficulties[index];
var rw = gs.reward_weights;
var tw = rw.none + rw.filler_loc + rw.filler_ite + rw.useful_loc + rw.useful_ite + rw.progre_loc + rw.progre_ite + rw.hint_token;
var rand = irandom_range(0,tw - 1);

if ((rand < rw.none)) {
	// none
	instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "You won!",desc:"...Nothing! lol"});
} else if ((rand < rw.filler_loc + rw.none)) {
	// filler location
	instance_create_layer(0,0,"notifications",obj_random_hint_location,{flag: 0});
} else if (rand < rw.filler_ite + rw.filler_loc + rw.none) {
	// filler item
	instance_create_layer(0,0,"notifications",obj_random_hint_item);
} else if (rand < rw.none + rw.filler_loc + rw.filler_ite + rw.useful_loc) {
	// useful location
	instance_create_layer(0,0,"notifications",obj_random_hint_location,{flag: 2});
} else if (rand < rw.none + rw.filler_loc + rw.filler_ite + rw.useful_loc + rw.useful_ite) {
	// useful item
} else if (rand < rw.none + rw.filler_loc + rw.filler_ite + rw.useful_loc + rw.useful_ite + rw.progre_loc) {
	// progressive location
	instance_create_layer(0,0,"notifications",obj_random_hint_location,{flag: 1});
} else if (rand < rw.none + rw.filler_loc + rw.filler_ite + rw.useful_loc + rw.useful_ite + rw.progre_loc + rw.progre_ite) {
	// progressive item
} else {
	// hint token
	global.hint_tokens++;
	instance_create_layer(0,0,"notifications",obj_hint_notification,{title: "You won!",desc:$"You won a Hint Token! (now at {global.hint_tokens}) Spend it in the Hint Tokens menu on the Main Menu!"});
}

instance_destroy();