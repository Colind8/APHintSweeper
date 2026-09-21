var border_offset = 10;

draw_sprite_stretched(spr_gameborder_top,0,board_posx - border_offset, board_draw_y, board_draw_width + (border_offset * 2), 44);
draw_sprite_stretched(spr_gameborder_bottom,0,board_posx - border_offset,board_draw_y + 44,board_draw_width + (border_offset * 2), board_draw_height + 8 + border_offset);
//draw_line_colour(room_width/2,0,room_width/2,room_height,c_aqua,c_aqua);