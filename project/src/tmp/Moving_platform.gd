extends Spatial


# Declare member variables here. Examples:
export var time_per_cycle = 10.0
export var loop = true
export var enable_on_start = false
export var enable_on_enter = false



onready var anim_player : AnimationPlayer = $AnimationPlayer



# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.playback_speed = 1.0/time_per_cycle
	if enable_on_start:		
		anim_player.play("CloudPath")
		
	pass # Replace with function body.


func enable_intern(body):
	if enable_on_enter:		
		anim_player.play("CloudPath")
		
func enable(body):
	anim_player.play("CloudPath")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
