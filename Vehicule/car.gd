extends VehicleBody3D

const MAX_STEER = 0.50
const ENGINE_POWER = 3000.0

@onready var camera_pivot = $CameraPivot
@onready var camera = $CameraPivot/Camera
@onready var reverse_camera = $CameraPivot/ReverseCamera

var look_at

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_default_cursor_shape(3)
	look_at = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if linear_velocity.dot(transform.basis.z) > 0:
		steering = move_toward(steering, Input.get_axis("right", "left") * (MAX_STEER - 0.25), delta * 2.5)
	else:
		steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 2.5)		
	engine_force = Input.get_axis("down", "up") * ENGINE_POWER
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 5.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	look_at = look_at.lerp(global_position + linear_velocity, delta * 5.0)
	camera.look_at(look_at)
	reverse_camera.look_at(look_at)
	_check_camera_switch()

func _check_camera_switch():
	if linear_velocity.dot(transform.basis.z) > 0.25:
		reverse_camera.current = true
	else:
		camera.current = true
