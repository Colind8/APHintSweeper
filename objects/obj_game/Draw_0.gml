var border_offset = 10;
var padding = 4;

draw_sprite_stretched(spr_gameborder_top,0,board_draw_x, board_draw_y, board_draw_width + (border_offset * 2), 44);
draw_sprite_stretched(spr_gameborder_bottom,0,board_draw_x,board_draw_y + 44,board_draw_width + (border_offset * 2), board_draw_height + 8 + border_offset);
draw_sprite(spr_segmentdisplay,floor((flags_to_place / 100)%10),board_draw_x + border_offset + padding,board_draw_y + border_offset + padding);
draw_sprite(spr_segmentdisplay,floor((flags_to_place / 10 )%10),board_draw_x + (13 * 1) + border_offset + padding,board_draw_y + border_offset + padding);
draw_sprite(spr_segmentdisplay,floor((flags_to_place)%10),board_draw_x + (13 * 2) + border_offset + padding,board_draw_y + border_offset + padding);