if ((unearthed == false) && (obj_game.game_stopped == false)) {
	sprite_index = spr_tile;
	image_index = flagged;
	
	if(collision_point(mouse_x,mouse_y,self,false,false)) {
		if (mouse_check_button(mb_left) && !flagged) {
			sprite_index = spr_tile_filled;
			image_index = 0;
			obj_face.image_index = 2;
		} else {
			if (obj_face.image_index == 2) {
				obj_face.image_index = 0;
			}
		}
		if (mouse_check_button_released(mb_left) && !flagged) {
			reveal();
		} else if (mouse_check_button_pressed(mb_right)) {
			flagged = !flagged;
			if (obj_game.flag_board[_y][_x] == 0) {
				obj_game.flag_board[_y][_x] = 1; // mark flagged
			} else {
				obj_game.flag_board[_y][_x] = 0 // remove flag
			}
			obj_game.check();
		}
		
	}
	
}