extends Spatial


export(Array, AudioStream ) var ahh_souds
export(Array, AudioStream ) var footstep_sounds
export(Array, AudioStream ) var yah_sounds
export(Array, AudioStream ) var ha_sounds
export(Array, AudioStream ) var chi_sounds
var sick_sound : AudioStream = preload("res://src/monster/Audio/Sick_1.ogg")
var door_sound : AudioStream = preload("res://src/monster/Audio/Door_1.ogg")

#onready var _audio_stream_player : AudioStreamPlayer3D = $"../AudioStreamPlayer3D"
onready var _audio_stream_player : AudioStreamPlayer = $"../AudioStreamPlayer"

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	PlayerData.connect("medizine_taken",self,"play_random_ahh")
	pass
	
func play_random_ahh()->void:
	ahh_souds.shuffle()
	var sound = ahh_souds.front()
	sound.loop = false
	_audio_stream_player.pitch_scale = 1
	_audio_stream_player.volume_db= 0
	_audio_stream_player.stream= sound
	_audio_stream_player.play()
	
	
func play_random_footstep()->void:
#	pass
	footstep_sounds.shuffle()
	var sound = footstep_sounds.front()#
	sound.loop = false#
	_audio_stream_player.stream= sound
	_audio_stream_player.volume_db= -10.0
	#_audio_stream_player.pitch_scale = 0.5
	_audio_stream_player.play()
	
	
func play_random_yah()->void:
	yah_sounds.shuffle()
	var sound = yah_sounds.front()
	sound.loop = false
	_audio_stream_player.pitch_scale = 1
	_audio_stream_player.volume_db= 0
	_audio_stream_player.stream= sound
	_audio_stream_player.play()
	
func play_sick_sound()->void:
	sick_sound.loop = false
	_audio_stream_player.pitch_scale = 1
	_audio_stream_player.volume_db= 0
	_audio_stream_player.stream= sick_sound
	_audio_stream_player.play()
	
func play_door_sound()->void:
	door_sound.loop = false
	_audio_stream_player.pitch_scale = 1
	_audio_stream_player.volume_db= 0
	_audio_stream_player.stream= door_sound
	_audio_stream_player.play()
	
	
	
	
func play_random_ha()->void:
	ha_sounds.shuffle()
	var sound = ha_sounds.front()
	sound.loop = false
	_audio_stream_player.volume_db= 0
	_audio_stream_player.pitch_scale = 1
	_audio_stream_player.stream= sound
	_audio_stream_player.play()
	
func play_random_chi()->void:
	chi_sounds.shuffle()
	var sound = chi_sounds.front()
	sound.loop = false
	_audio_stream_player.pitch_scale = 1
	_audio_stream_player.volume_db= 0
	_audio_stream_player.stream= sound
	_audio_stream_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
