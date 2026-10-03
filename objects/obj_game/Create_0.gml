randomize();

show_debug_message("Created!")

flags_to_place = total_mines;
first_click = true;
game_stopped = false;

board_draw_width = (16 * board_width);
board_draw_height = (16 * board_height);
board_posx = room_width/2 - (board_draw_width / 2);
board_posy = 52;
board_draw_x = board_posx - 10;
board_draw_y = board_posy - 52;

board = []; //0-8 numbers, 9 bombs
flag_board = [] // 0 hidden, 1 flagged, 2 revealed

instance_create_layer(board_draw_x + (board_draw_width / 2) + 10 - 12,board_draw_y + 14,"game_tiles",obj_face);

// Create blank board
for (var i = 0; i < board_height; i++) {
	var board_row = [];
	var flag_board_row = []
	for (var j = 0; j < board_width; j++) {
		array_push(board_row,0);
		array_push(flag_board_row,0);
	}
	array_push(board,board_row);
	array_push(flag_board,flag_board_row);
}

// Place mines
// Theoretically this can run forever but lol
for (var i = 0; i < total_mines; i++) {
	var mine_placeable = false;
	while (!mine_placeable) {
		var randx = irandom_range(0,board_width - 1);
		var randy = irandom_range(0, board_height - 1);
		if (board[randy][randx] != 9) {
			board[randy][randx] = 9;
			mine_placeable = true;
		}
	}
}

// Fill in numbers
write_numbers();
function write_numbers() {
	for (var i = 0; i < board_height; i++) {
		for (var j = 0; j < board_width; j++) {
			if (board[i][j] != 9) {
				var bomb_count = 0;
				try {
					if (board[i - 1][j - 1] == 9) { // top-left
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				try {
					if (board[i - 1][j] == 9) { // top-middle
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				try {
					if (board[i - 1][j + 1] == 9) { // top-right
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				try {
					if (board[i][j - 1] == 9) { // center-left
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				try {
					if (board[i][j + 1] == 9) { // center-right
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				try {
					if (board[i + 1][j - 1] == 9) { // bottom-left
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				try {
					if (board[i + 1][j] == 9) { // bottom-middle
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				try {
					if (board[i + 1][j + 1] == 9) { // bottom-right
						bomb_count++;
					}
				} catch (e) {
					show_debug_message("out of bounds lol");
				}
				
				board[i][j] = bomb_count;
			}  
			
		}
	}
}


// Spawn tile objects
for (var i = 0; i < board_height; i++) {
	for (var j = 0; j < board_width; j++) {
		instance_create_layer(board_posx + (16 * j),board_posy + (16 * i),"game_tiles",obj_tile,{_x: j, _y: i});
	}
}

time_up = function() {
	instance_create_layer(0,0,"notifications",obj_hint_notification,{
		title: "Time up!",
		desc: "You ran out of time."
	});
	game_over(-1,-1);
}

time_source = 0;

if (time != -1) {
	time_source = time_source_create(time_source_global,time,time_source_units_seconds,time_up);
	time_source_start(time_source);
}



function check() {
	var correct_mines = 0;
	flags_to_place = total_mines;
	for (var i = 0; i < board_height; i++) {
		for (var j = 0; j < board_width; j++) {
			if ((board[i][j] == 9) && (flag_board[i][j] == 1)) { //if mine flagged
				correct_mines++;
				flags_to_place--;
			}
			if (flag_board[i][j] == 0) { // for every unrevealed tile
				correct_mines++;
			}
		}
	}
	if (correct_mines == total_mines) {
		if (!game_stopped) {
			show_debug_message("You win!");
			flags_to_place = 0;
			game_stopped = true;
			obj_face.image_index = 4;
			instance_create_layer(0,0,"instances",obj_hint,{index: index});
			if (time != -1) {
				time_source_pause(time_source);
			}
		}
	} else {
		show_debug_message($"Game not yet won. {correct_mines} vs {total_mines}");
	}
	
}
function reveal_tile(_x,_y) {
	var inst = instance_position(8 + board_posx + (16 * _x), 8 + board_posy + (16 * _y), obj_tile);
	if (inst != noone) {
		if (inst.unearthed == false) {
			inst.reveal();
		}
	} else {
		show_debug_message($"Inst not found at x: {8 + board_posx + (16 * _x)}, y: {8 + board_posy + (16 * _y)}")
	}
}

function reveal_chain(_x, _y) {
	show_debug_message("Activated reveal chain");
	try {
		reveal_tile(_x - 1,_y - 1);
	} catch (e) {
		show_debug_message("bruh");
		show_debug_message(e.message);
	}
	try {
		reveal_tile(_x,_y - 1);
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		reveal_tile(_x + 1,_y - 1);
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		reveal_tile(_x - 1,_y);
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		reveal_tile(_x + 1,_y);
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		reveal_tile(_x - 1,_y + 1);
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		reveal_tile(_x,_y + 1);
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		reveal_tile(_x + 1,_y + 1);
	} catch (e) {
		show_debug_message(e.message);
	}
}

function first_click_set(_x,_y) {
	show_debug_message("FIXING FIRST CLICK");
	
	// Remove all bombs in area
	var _bombs_removed = 0;
	try {
		if (board[_y][_x] == 9) { //center
			_bombs_removed++;
			board[_y][_x] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y - 1][_x - 1] == 9) { // top-left
			_bombs_removed++;
			board[_y - 1][_x - 1] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y - 1][_x] == 9) { //top-middle
			_bombs_removed++;
			board[_y - 1][_x] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y - 1][_x + 1] == 9) { // top-right
			_bombs_removed++;
			board[_y - 1][_x + 1] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y][_x - 1] == 9) { // center-left
			_bombs_removed++;
			board[_y][_x - 1] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y][_x + 1] == 9) { // center-right
			_bombs_removed++;
			board[_y][_x + 1] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y + 1][_x - 1] == 9) { // bottom-left
			_bombs_removed++;
			board[_y + 1][_x - 1] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y + 1][_x] == 9) { // bottom-middle
			_bombs_removed++;
			board[_y + 1][_x] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	try {
		if (board[_y + 1][_x + 1] == 9) { // bottom-right
			_bombs_removed++;
			board[_y + 1][_x + 1] = 0;
		}
	} catch (e) {
		show_debug_message(e.message);
	}
	
	// Replace all bombs removed
	for (var i = 0; i < _bombs_removed; i++) {
		var mine_placeable = false;
		var pos_works = true;
		while (!mine_placeable) {
			var randx = irandom_range(0,board_width - 1);
			var randy = irandom_range(0, board_height - 1);
			pos_works = true;
			if (board[randy][randx] != 9) {
				try {
					if ((_x - 1 == randx) && (_y - 1 == randy)) { //top-left
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x == randx) && (_y - 1 == randy)) { //top-middle
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x + 1 == randx) && (_y - 1 == randy)) { // top-right
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x - 1 == randx) && (_y == randy)) { // middle-left
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x + 1 == randx) && (_y == randy)) { //middle-right
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x == randx) && (_y == randy)) { //middle-middle
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x - 1 == randx) && (_y + 1 == randy)) { //bottom-left
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x == randx) && (_y + 1 == randy)) { //bottom-middle
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				try {
					if ((_x + 1 == randx) && (_y + 1 == randy)) { //bottom-right
						pos_works = false;
					}
				} catch (e) {
					show_debug_message(e.message);
				}
				
				show_debug_message($"position {randx},{randy} works: {pos_works}");
				
				if (pos_works) {
					board[randy][randx] = 9;
					mine_placeable = true;
				}
				
			}
		}
	}
	
	// re-write numbers
	write_numbers();
}

function game_over(_x,_y,from_deathlink = false) {
	show_debug_message("GAME OVER!!!!");
	if (time != -1) {
		time_source_pause(time_source);
	}
	game_stopped = true;
	var inst = 0;
	obj_face.image_index = 3;
	if (from_deathlink == false) {
		if (global.deathlink) {
			var date1 = date_create_datetime(1970,1,1,0,0,0);
			var date2 = date_current_datetime();
			var unix_time = floor(real(date_second_span(date1,date2)));
			send_command({
				cmd: "Bounce",
				tags: ["DeathLink"],
				data: {
					time: unix_time,
					cause: $"{global.name} stepped on a landmine!",
					source: global.name
				}
			});
		}
	}
	
	for (var i = 0; i < board_height; i++) {
		for (var j = 0; j < board_width; j++) {
			show_debug_message($"{j},{i}: {board[i][j]} -- {flag_board[i][j]} -- {(i == _y) && (j == _x)}")
			if(!((i == _y) && (j == _x))) {
				inst = instance_position(8 + board_posx + (16 * j), 8 + board_posy + (16 * i), obj_tile);
				if ((board[i][j] == 9) && (flag_board[i][j] == 0)) {
					show_debug_message("bomb found");
					inst.unearthed = true;
					inst.sprite_index = spr_tile_filled;
					inst.image_index = 9;
				} else if ((board[i][j] != 9) && (flag_board[i][j] == 1)) {
					show_debug_message("flag wrong");
					inst.unearthed = true;
					inst.sprite_index = spr_tile_filled;
					inst.image_index = 10;
				}
			}
		}
	}
}