extends KinematicBody

const MIN_CAM_ANGLE = -60
const MAX_CAM_ANGLE = 70

const GRAVITY = -30


export var camera_sensitivity: float = 0.05
export var speed: float = 10.0
export var acceleration: float = 10.0
export var jump_impulse: float = 15.0


# Weapon System
var weapons = []
var current_weapon_index = 0

onready var gun1 = $Head/Hand/gun1

func weapon_select():
	
	if Input.is_action_just_pressed("weapon1"):
		if current_weapon_index == 1:
			current_weapon_index = 0
		else:
			current_weapon_index = 1
		
		

	if current_weapon_index == 1:
		gun1.visible = true
	else:
		gun1.visible = false
	

		
func switch_weapon():
		current_weapon_index += 1
		
		if current_weapon_index >= weapons.size():
			current_weapon_index = 0

# Velocity

var velocity: Vector3 = Vector3.ZERO

onready var head: Spatial = $Head

func _ready():
	
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _physics_process(delta):
	
		weapon_select()
		var movement = _get_movement_direction()	
		
		velocity.x = lerp(velocity.x, movement.x * speed, acceleration * delta)
		velocity.z = lerp(velocity.z, movement.z * speed, acceleration * delta)
		velocity.y += GRAVITY * delta
		velocity = move_and_slide(velocity, Vector3.UP)

func _unhandled_input(event):
		if event is InputEventMouseMotion:
				_handle_camera_rotation(event)

func _handle_camera_rotation(event):
		rotate_y(deg2rad(-event.relative.x * camera_sensitivity))
		head.rotate_z((deg2rad(-event.relative.y * camera_sensitivity)))
		head.rotation.z = clamp(head.rotation.z, deg2rad(MIN_CAM_ANGLE), deg2rad(MAX_CAM_ANGLE))



func _get_movement_direction():
	var direction = Vector3.DOWN
	
	if Input.is_action_pressed("back"):
		direction -= transform.basis.x
	if Input.is_action_pressed("forward"):
		direction += transform.basis.x
	if Input.is_action_pressed("left"):
		direction -= transform.basis.z
	if Input.is_action_pressed("right"):
		direction += transform.basis.z
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_impulse
	
	return direction.normalized()
