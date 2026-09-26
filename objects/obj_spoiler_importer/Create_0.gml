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
			
			// This will break if an item, player, or location has ( or ) in their names. Should probably use regex instead or something.
			if (string_length(string_trim(line)) > 0) {
				var line_index = 1;
				var location_str = "";
				while (string_char_at(line,line_index) != "(") {
					location_str += string_char_at(line,line_index);
					line_index++;
				}
				location_str = string_delete(location_str, string_length(location_str), 1);
				line_index++;
				var location_player_str = "";
				while (string_char_at(line,line_index) != ")") {
					location_player_str += string_char_at(line,line_index);
					line_index++;
				}
				line_index+= 3;
				var item_str = "";
				while (string_char_at(line,line_index) != "(") {
					item_str += string_char_at(line,line_index);
					line_index++;
				}
				item_str = string_delete(item_str, string_length(item_str), 1);
				line_index++;
				var item_player_str = "";
				while (string_char_at(line,line_index) != ")") {
					item_player_str += string_char_at(line,line_index);
					line_index++;
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

show_debug_message(pair_array[0]);
show_debug_message(pair_array[array_length(pair_array) - 1]);
layer_set_visible("importer",false);
layer_set_visible("login_screen",true);
layer_set_visible("settings",true);
layer_set_visible("difficulty_customization",false);
layer_set_visible("difficulty_customization_assets",false);
layer_set_visible("assets",true);
obj_am_login.temp_admin_settings.item_hints = true;
show_message("Import complete!");