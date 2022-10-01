extends Button


export var path_to_scene : String = "" 


func _on_button_up():
	SceneManager.load_main_menu()

