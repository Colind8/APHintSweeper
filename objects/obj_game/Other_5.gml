if (time_source_exists(time_source)) {
	show_debug_message("Timesource destroyed!");
	time_source_destroy(time_source);
}
