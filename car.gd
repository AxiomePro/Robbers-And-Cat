extends VehicleBody3D

const MAX_STEER = 0.50
const ENGINE_POWER = 2500.0

@onready var camera_pivot = $CameraPivot
@onready var camera = $CameraPivot/Camera
@onready var reverse_camera = $CameraPivot/ReverseCamera
@onready var audio = $AudioStreamPlayer
@onready var audio2 = $AudioStreamPlayer2

var look_at

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Input.set_default_cursor_shape(3)
	look_at = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.time_scale == 1:
		if Input.is_action_just_pressed("Menu"):
			get_tree().change_scene_to_file("res://Menu/menu.tscn")
		if linear_velocity.dot(transform.basis.z) > 0:
			steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER / 2, delta * 2.5)
		else:
			steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 2.5)
		engine_force = Input.get_axis("down", "up") * ENGINE_POWER
		camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 5.0)
		camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
		look_at = look_at.lerp(global_position + linear_velocity, delta * 5.0)
		camera.look_at(look_at)
		reverse_camera.look_at(look_at)
		_check_camera_switch()
		_audio_switch()

func _audio_switch():
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		audio.playing = true
		audio2.playing = false
	if Input.is_action_just_released("up") or Input.is_action_just_released("down"):
		audio.playing = false
		audio2.playing = true

func _on_audio_finished():
	audio.playing = true

func _check_camera_switch():
	if Engine.time_scale == 1:
		if linear_velocity.dot(transform.basis.z) > 1:
			reverse_camera.current = true
		else:
			camera.current = true