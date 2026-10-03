var file;
try {
	file = file_text_open_read(file_name);
} catch (e) {
	show_message(e.message);
	return;
}

var stage = 0;
var pair_array = [];
var line_num = 0;
show_debug_message("Starting IMPORTER");
while (!file_text_eof(file))
{
	line_num++;
	show_debug_message($"Reading Line {line_num}");
	var line = "";
    switch (stage) {
		case 0:
			line = file_text_readln(file);
			//show_debug_message($"Line: {line}");
			if (string_trim(line) == "Locations:") {
				show_debug_message("Found Start of Locations list!");
				file_text_readln(file);
				stage = 1;
			}
			break;
		case 1:
			line = file_text_readln(file);
			
			// This will break if an item, player, or location has "): " in their names.
			if (string_length(string_trim(line)) > 0) {
				var line_index = 1;
				var end_location_index = -1;
				var location_str = "";
				var item_str = "";
				var item_player_str = "";
				var location_player_str = "";
				
				var end_location_bool = (string_char_at(line,line_index) == ")") && (string_char_at(line,line_index + 1) == ":") && (string_char_at(line,line_index + 2) == " ");
				var end_item_bool = (string_char_at(line,line_index - 2) == ")") && (string_char_at(line,line_index - 1) == ":") && (string_char_at(line,line_index) == " ");
				

				while(!end_location_bool) {
					end_location_bool = (string_char_at(line,line_index) == ")") && (string_char_at(line,line_index + 1) == ":") && (string_char_at(line,line_index + 2) == " ");

					line_index++;
				}
				line_index -= 2;
				while (string_char_at(line,line_index) != "(") {
					location_player_str = string_char_at(line,line_index) + location_player_str;
					line_index--;
				}
				line_index -= 2;
				
				while (line_index != 0) {
					location_str = string_char_at(line,line_index) + location_str;
					line_index--;
				}
				line_index = string_length(line) - 3;
				while(string_char_at(line,line_index) != "(") {
					item_player_str = string_char_at(line,line_index) + item_player_str;
					line_index--;
				}
				show_debug_message("stage 5");
				line_index--;
				while (!end_item_bool) {
					end_item_bool = (string_char_at(line,line_index - 2) == ")") && (string_char_at(line,line_index - 1) == ":") && (string_char_at(line,line_index) == " ");
					item_str = string_char_at(line,line_index) + item_str;
					line_index--;
				}
				
				array_push(pair_array,{
					loc: location_str,
					loc_plr: location_player_str,
					ite: item_str,
					ite_plr: item_player_str
				});
				show_debug_message($"Item {array_length(pair_array)} added!");
			} else {
				stage = 2;
				show_debug_message("Reached end of locations list, going to end of file");
			}
			
			break;
		case 2:
			file_text_readln(file);
			break;
	}
}
file_text_close(file);
if (stage == 2) {
	obj_am_login.temp_admin_settings.item_hints = true;
	obj_am_login.temp_spoiler = pair_array;
	show_message("Import complete!");
} else {
	show_message("Importer process failed.");
	obj_am_import_spoiler.disabled = false;
}

instance_destroy();