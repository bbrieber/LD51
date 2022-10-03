extends Spatial

onready var anim_player: AnimationPlayer = $AnimationPlayer

func _on_portal_entered(body):
	$AudioStreamPlayer.play()
	TimerManager.stop_timer()
	anim_player.play("OpenDoor")


func go_to_net_level():
	SceneManager.load_next_level()
