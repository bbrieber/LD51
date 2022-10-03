extends Node

export var path_to_menu_scene : String = "" 
export var path_to_win_scene : String = "" 
export var path_to_die_scene : String = "" 


export  (Array, String) var  path_to_levels_array 


var current_level = -1

func load_main_menu() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene(path_to_menu_scene)

func load_win_screen() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene(path_to_win_scene)

func load_death_screen() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	get_tree().change_scene(path_to_die_scene)
	

func load_first_level() -> void:	
	get_tree().paused = false
	current_level = 0;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	print(path_to_levels_array[current_level])
	get_tree().change_scene(path_to_levels_array[current_level])

func load_last_level() -> void:	
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	get_tree().change_scene(path_to_levels_array[current_level])

func load_next_level() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	current_level += 1;
	print(path_to_levels_array[current_level])
	get_tree().change_scene(path_to_levels_array[current_level])
	
