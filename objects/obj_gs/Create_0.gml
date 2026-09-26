for (var i = 0; i < array_length(obj_network.admin_settings.difficulties); i++) {
	var gs = obj_network.admin_settings.difficulties[i];
	var rw = gs.reward_weights;
	var str = "";
	str += $"Size: {gs.width}x{gs.height}, Mines: {gs.mines}";
	if (gs.timed) {
		str+= $"\nTime Limit: {gs.time}";
	}
	str+= "\n\nReward Chances:";
	var tw = rw.none + rw.filler_loc + rw.filler_ite + rw.useful_loc + rw.useful_ite + rw.progre_loc + rw.progre_ite + rw.hint_token;
	if (rw.none > 0) {
		str+= $"\nNone: {floor((rw.none / tw) * 100)}%";
	}
	if (rw.filler_loc > 0) {
		str+= $"\nFiller/Trap Location: {floor((rw.filler_loc / tw) * 100)}%";
	}
	if (rw.useful_loc > 0) {
		str+= $"\nUseful Location: {floor((rw.useful_loc / tw) * 100)}%";
	}
	if (rw.progre_loc > 0) {
		str+= $"\nProgressive Location: {floor((rw.progre_loc / tw) * 100)}%";
	}
	if (rw.filler_ite > 0) {
		str+= $"\nFiller/Trap Item: {floor((rw.filler_ite / tw) * 100)}%";
	}
	if (rw.useful_ite > 0) {
		str+= $"\nUseful Item: {floor((rw.useful_ite / tw) * 100)}%";
	}
	if (rw.progre_ite > 0) {
		str+= $"\nProgressive Item: {floor((rw.progre_ite / tw) * 100)}%";
	}
	if (rw.hint_token > 0) {
		str+= $"\nHint Token: {floor((rw.hint_token / tw) * 100)}%";
	}
	
	instance_create_layer(room_width/2, 64 + (i * 32),"instances",obj_gs_diffselect,{
		index: i,
		tooltip_text: str,
		text: gs.name
	});
}