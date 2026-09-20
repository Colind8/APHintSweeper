unearthed = false;

function reveal() {
	unearthed = true;
	show_debug_message($"Revealing {_x},{_y}");
	if ((obj_game.first_click) && (obj_game.board[_y][_x] != 0)) {
		obj_game.first_click_set(_x,_y);
	}
	obj_game.first_click = false;
	sprite_index = spr_tile_filled;
	image_index = obj_game.board[_y][_x];
	obj_game.flag_board[_y][_x] = 2;
	if (obj_game.board[_y][_x] == 0) {
		obj_game.reveal_chain(_x,_y);
	}
	if (obj_game.board[_y][_x] == 9) {
		image_index = 11;
		obj_game.game_stopped = true;
		obj_game.game_over(_x,_y);
	} else {
		obj_game.check();
	}
}