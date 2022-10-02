extends Node


onready var music_player: AudioStreamPlayer = get_node("MusicPlayer")
export var sound_file_path : String = ""
var music = preload("res://src/music/LD51.ogg")





# Called when the node enters the scene tree for the first time.
func _ready():
	music_player.stream = music
	play_music() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_music():
	music_player.play()
	
func stop_music():
	music_player.stop()
