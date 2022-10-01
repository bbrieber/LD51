extends Node

onready var timer: Timer = get_node("Timer")

signal on_timer_over




func _on_timeout():
	emit_signal("on_timer_over")
	print("timer over")
	pass # Replace with function body.

func reset_timer():
	print("timer started")
	timer.start()
	
	
func stop_timer():
	timer.stop()
