active = false;
disabled = false;
tooltip_cooldown = 60;

function on_active() {
	show_debug_message("on_active not overridden!");
}
function on_inactive() {
	show_debug_message("on_inactive not overridden!");
}