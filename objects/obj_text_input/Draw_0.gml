draw_self();
draw_set_font(fnt_large);
draw_set_colour(c_black);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
var pad = 2;
var bit_pos = string_width(text) + x + pad;

if (disabled) {
	draw_set_colour(c_gray);
}
draw_text(x + pad,y + ceil(sprite_height) - pad,text);

if (active) {
	draw_line(bit_pos,y + pad, bit_pos, y - (pad * 2) + sprite_height);	
}
if ((text == "")) {
	draw_set_colour(c_gray);
	draw_text(x + pad,y + ceil(sprite_height) - pad,sample_text);
}

draw_set_colour(c_white);