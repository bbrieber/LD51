extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")

onready var health_bar: ProgressBar = get_node("Control/HealthBar")
onready var tutorial_text: Label = get_node("TutorialPanel/TutorialText")
onready var tutorial_panel: Panel = get_node("TutorialPanel")


var paused : =false setget set_paused

func _ready() -> void:
	PlayerData.connect("health_changed",self,"_on_health_changed")

func _on_health_changed() -> void:
	print("Health %d" % PlayerData.health)
	health_bar.value = PlayerData.health

func _unhandled_input(event):
	if event.is_action("Pause") && event.is_pressed():
		self.paused = !paused
		scene_tree.set_input_as_handled()
	
func set_paused(value):
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _on_continue_button_up():
	self.paused = false


func _on_restart_button_up():
	get_tree().reload_current_scene()
	self.paused = false



func show_tutorial_text(input_text):
	tutorial_panel.visible = true
	tutorial_text.text = input_text
	
	

func hide_tutorial_text():
	tutorial_panel.visible = false
	
