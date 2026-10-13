var _x = x;
var _y = y;
var desc = "Your hint is currently being created. Please wait."

draw_set_halign(fa_center);
draw_set_valign(fa_top);
var _width = 300;
var _sep = 15;
var _str_h = string_height_ext(desc,_sep,_width);
var _str_w = string_width_ext(desc,_sep,_width);
var _pad = 5;
var _mar = 10;
var _spr_w = _width;
var _spr_h = _str_h + (_pad * 2)
_x = x - (_spr_w /2);
draw_self();
draw_set_colour(c_black);

draw_set_font(fnt_larger);

draw_text(x + (sprite_width / 2), y + _pad,"Please wait...");


draw_set_font(global.font);

draw_text_ext(x + (sprite_width / 2), (y + _pad + (_sep * 4)), desc, _sep, _width - (_pad));
