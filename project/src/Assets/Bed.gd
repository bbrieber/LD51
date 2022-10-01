extends Spatial




func _on_bed_entered(body):
	print(body.name)
	SceneManager.load_win_screen()
