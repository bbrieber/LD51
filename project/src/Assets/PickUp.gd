extends Spatial

export var health_amount : int = 30

onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("Spin")

func on_pickup(body):
	PlayerData.health += health_amount
	PlayerData.trigger_med_taken()
	TimerManager.reset_timer()
	queue_free()
