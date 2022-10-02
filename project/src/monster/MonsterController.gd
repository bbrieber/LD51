extends KinematicBody

export var speed := 4.2
export var jump_strength := 20.0
export var gravity := 50.0 

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

onready var _spring_arm : SpringArm = $CameraBoom
onready var _model : Spatial = $MonsterSkeleton


onready var animation_tree : AnimationTree = $AnimationTree
onready var state_machine  = animation_tree.get("parameters/locomotion/playback")



var is_in_air  setget set_is_in_air, get_is_in_air
var is_moving  setget set_is_moving, get_is_moving

func set_is_in_air(value):
	animation_tree.set("parameters/locomotion/conditions/is_on_ground",not value)
	animation_tree.set("parameters/locomotion/conditions/is_in_air", value)
	#print("is on ground ",value)
func get_is_in_air():
	return animation_tree.get("parameters/locomotion/conditions/is_in_air")
	
	
func set_is_moving(value):
	animation_tree.set("parameters/locomotion/conditions/is_moving",value)
	animation_tree.set("parameters/locomotion/conditions/is_idle",not value)
	#print("is moving ",value)
func get_is_moving():
	return animation_tree.get("parameters/locomotion/conditions/is_moving")
	
	
	

func set_locomotion_speed(speed) -> void:
	animation_tree.set("parameters/locomotion/Move/blend_position",speed)

func _ready() -> void:
	TimerManager.connect("on_timer_over",self,"timer_over")
	PlayerData.connect("player_died",self,"on_player_died")
	PlayerData.reset_health()
	TimerManager.reset_timer()

func timer_over() -> void:
	TimerManager.reset_timer()
	animation_tree.set("parameters/hatschi_1/active",true)
	
	print("Hatchi")
	PlayerData.health += -1

func _physics_process(delta) -> void:
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	move_direction.z = Input.get_action_strength("Backward") - Input.get_action_strength("Forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized() #FIXME remove this normalized

	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("Jump")
	
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
		state_machine.travel("Jump_Start")
	elif just_landed:
		_snap_vector = Vector3.DOWN
		
	self.is_in_air = not is_on_floor()
	_velocity = move_and_slide_with_snap(_velocity,_snap_vector,Vector3.UP,true)
	
	print(_velocity.length())
	if _velocity.length() > 0.2 and not is_jumping :
		var look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angle()		
		self.is_moving =true 
	elif _velocity.length() < 0.2 and not is_jumping :
		self.is_moving =false 
	set_locomotion_speed(_velocity.length())
	
	

func _process(delta) -> void:
	#_spring_arm.translation = translation
	pass


func on_player_died()->void:
	SceneManager.load_death_screen()
