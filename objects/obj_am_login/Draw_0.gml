var _x = x;
var _y = y;
draw_set_font(fnt_large);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
var _width = 114;
var _sep = 15;
var _str_h = string_height_ext(text,_sep,_width);
var _str_w = string_width_ext(text,_sep,_width);
var _pad = 2;
var _mar = 10;
var _spr_w = _width;
var _spr_h = _str_h + (_pad * 2)
_x = x - (_spr_w /2);
if (point_in_rectangle(mouse_x,mouse_y,_x,_y,_x + _spr_w, _y + _spr_h)) {
	mouse_over = true;
} else {
	mouse_over = false;
}

draw_sprite_stretched(sprite_index,image_index,_x,_y,_spr_w,_spr_h);

draw_set_colour(c_black);

if (disabled) {
	draw_set_colour(c_gray);
}

draw_text_ext(_x + (_spr_w/2), _y + _pad, text, _sep, _width - (_pad));

draw_set_halign(fa_left);
draw_set_colour(message_color);
draw_text(_spr_w + _x + _mar, _y,login_message);