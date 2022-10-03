extends Node


onready var ui := get_node("../InGameUi")


export (String, MULTILINE) var welcome_text 
export (String, MULTILINE) var medicine_text
export (String, MULTILINE) var jump_text
export (String, MULTILINE) var door_text 
export (String, MULTILINE) var last_text 


var med_text_shown = false
var jump_text_shown = false
var door_text_shown  = false
var last_text_shown  = false

# Called when the node enters the scene tree for the first time.
func _ready():
	show_text(welcome_text,10)

func show_text(text,time):
	ui.show_tutorial_text(text)
	var t = Timer.new()
	t.set_wait_time(time)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	ui.hide_tutorial_text()
	
	
func show_medicine_text():
	show_text(medicine_text,10)
	
	
func show_door_text():
	show_text(door_text,10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_jump_trigger_entered(body):
	if not jump_text_shown:
		show_text(jump_text,10)
		jump_text_shown = true
		
		
func _on_medicine_trigger_entered(body):
	if not med_text_shown:
		show_medicine_text()
		med_text_shown = true


func _on_door_trigger_entered(body):
	if not door_text_shown:
		show_text(door_text,10)
		door_text_shown = true


func _on_last_trigger_entered(body):
	if not last_text_shown:
		show_text(last_text,10)
		last_text_shown = true
