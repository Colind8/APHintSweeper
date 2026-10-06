draw_set_font(fnt_larger);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_colour(c_black);
draw_text(room_width/2,room_height/2,$"Saving {ind} / {array_length(slot_names)}");
draw_text(room_width/2,room_height/2 + 30,$"{split_ind} / {array_length(temp_arr)}");