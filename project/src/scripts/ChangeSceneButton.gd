extends Button


export var path_to_scene : String = "" 


func _on_button_up():
	get_tree().paused = false
	get_tree().change_scene(path_to_scene)
