var _x = x;
var _y = y;
draw_set_font(fnt_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _width = 250;
var _sep = 12;
var _str_h = string_height_ext(text,_sep,_width);
var _str_w = string_width_ext(text,_sep,_width);
var _pad = 2;
var _mar = 10;
var _spr_w = _str_w + (_pad * 2);
var _spr_h = _str_h + (_pad * 2)

if (mouse_x <= room_width/2) {
	_x = x + _mar;
} else {
	_x = x - _mar - _spr_w;
}
if (mouse_y <= room_height/2) {
	_y = y + _mar;
} else {
	_y = y - _mar - _spr_h;
}


draw_sprite_stretched(spr_tooltip,0,_x,_y,_spr_w,_spr_h);
draw_set_colour(c_black);

draw_text_ext(_x + _pad, _y + _pad, text, _sep, _width - (_pad));