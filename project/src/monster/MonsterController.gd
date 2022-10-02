extends KinematicBody

export var speed := 4.2
export var jump_strength := 20.0
export var gravity := 50.0 

export var tick_damage := 20.0 

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

var _movement_blocked := false

onready var _spring_arm : SpringArm = $CameraBoom
onready var _model : Spatial = $MonsterSkeleton


onready var animation_tree : AnimationTree = $AnimationTree
onready var state_machine  = animation_tree.get("parameters/locomotion/playback")

var rng = RandomNumberGenerator.new()

var is_in_air  setget set_is_in_air, get_is_in_air
var is_moving  setget set_is_moving, get_is_moving

var jump_trigger = false
 
func _ready() -> void:
	TimerManager.connect("on_timer_over",self,"timer_over")
	PlayerData.connect("player_died",self,"on_player_died")
	PlayerData.reset_health()
	TimerManager.reset_timer()
	rng.randomize()
	
var hatchi_path = "parameters/hatschi_%d/active"

func timer_over() -> void:
	var num = rng.randi_range(1, 3)
	var actual_hatchi_path=hatchi_path %num
	print(actual_hatchi_path)
	animation_tree.set(actual_hatchi_path,true)
	
	TimerManager.reset_timer()
	PlayerData.health -= tick_damage

func _physics_process(delta) -> void:
	var move_direction := Vector3.ZERO
	if(not _movement_blocked ):
		move_direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		move_direction.z = Input.get_action_strength("Backward") - Input.get_action_strength("Forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized() #FIXME remove this normalized

	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := not _movement_blocked and is_on_floor() and Input.is_action_just_pressed("Jump") 
	
	if is_jumping:
		state_machine.travel("Jump_Start")
	elif jump_trigger:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
		jump_trigger = false
	elif just_landed:
		_snap_vector = Vector3.DOWN
		
	self.is_in_air = not is_on_floor()
	_velocity = move_and_slide_with_snap(_velocity,_snap_vector,Vector3.UP,true)
	
	if _velocity.length() > 0.2 and not is_jumping :
		var look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angle()		
		self.is_moving =true 
	elif _velocity.length() < 0.2 and not is_jumping :
		self.is_moving =false 
	set_locomotion_speed(_velocity.length())
	
	
func set_jump_trigger()->void:
	jump_trigger = true

func block_movement():
	_movement_blocked = true
	print("block_movement")
func free_movement():
	_movement_blocked = false
	print("free_movement")

func _process(delta) -> void:
	#_spring_arm.translation = translation
	pass


func on_player_died()->void:
	init_death()
	#SceneManager.load_death_screen()
	
	
	
#State machine Calls	
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

func init_death() -> void:
	_movement_blocked = true
	animation_tree.set("parameters/sick_blend/blend_amount",1)
	var t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	SceneManager.load_death_screen()
