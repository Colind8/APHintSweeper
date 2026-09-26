if (room != rm_game) {
	return;
}
instance_create_layer(0,0,"instances",obj_game,{
	board_width: w,
	board_height: h,
	total_mines: m,
	time: t,
	index: i
});
instance_destroy();