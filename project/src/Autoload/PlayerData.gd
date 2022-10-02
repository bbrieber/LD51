extends Node

export var max_health :int = 100

var points: int = 0 setget set_points
var try_count : int = 0 setget set_try_count
var health : int  = 0 setget set_health

signal points_changed
signal try_count_changed
signal health_changed


signal medizine_taken


signal player_died

func reset_health():
	self.health = max_health

func set_points(value: int) -> void:
	points = value
	emit_signal("points_changed")

func set_try_count(value: int) -> void:
	try_count = value
	emit_signal("try_count_changed")


func set_health(value: int) -> void:
	health = clamp(value,0,100)
	
	emit_signal("health_changed")
	if health == 0:
		emit_signal("player_died")
	

func trigger_med_taken() -> void:
	emit_signal("medizine_taken")
