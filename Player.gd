extends KinematicBody

export var speed := 10.0
export var acceleration := 5.0
export var gravity := 0.98
export var jump_power := 30.0
var mouse_sensitivity := 0.3

onready var head: Spatial = $Head
onready var camera: Camera = $Head/Camera

onready var Gun = $Head/Camera/Weapons/Pistol

var velocity := Vector3()
var camera_x_rotation = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		
		var x_delta = event.relative.y *mouse_sensitivity
		if camera_x_rotation + x_delta > - 90 && camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta
			
func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	var head_basis: Basis = head.get_global_transform().basis
	
	var direction := Vector3()
	
	direction += head_basis.z * Input.get_axis("move_forward", "move_backward")
	direction += head_basis.x * Input.get_axis("move_left", "move_right")
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction*speed, acceleration*delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y += jump_power
		
	if Input.is_action_pressed("primary_fire"):
		Gun.Shoot()
		
	velocity = move_and_slide(velocity, Vector3.UP)
