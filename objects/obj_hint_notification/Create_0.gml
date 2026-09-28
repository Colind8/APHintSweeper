image_xscale = 40;
image_yscale = 20;
x = (room_width/2) - (sprite_width / 2);
y = (room_height/2) - (sprite_height / 2);
instance_create_layer(x + (sprite_width / 2),y + sprite_height - 30,layer, obj_hn_close);