extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.3
const SENSITIVITY = 0.0005
const MIN_Y = -60
const MAX_Y = 40
#bob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var time = 0.0

#Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 13

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var flashlight = $Head/SpotLight3D
@onready var flashlight2 = $Head/SpotLight3D2


func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#pass
	Input.set_mouse_mode (Input. MOUSE_MODE_CAPTURED)
	#Input.set_mouse_mode(Input.M)

func _unhandled_input (event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(MIN_Y), deg_to_rad(MAX_Y))
		flashlight.rotate_x(-event.relative.y * SENSITIVITY)
		flashlight.rotation.x = clamp(flashlight.rotation.x, deg_to_rad(MIN_Y), deg_to_rad(MAX_Y))
		flashlight2.rotate_x(-event.relative.y * SENSITIVITY)
		flashlight2.rotation.x = clamp(flashlight2.rotation.x, deg_to_rad(MIN_Y), deg_to_rad(MAX_Y))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0 #move_toward(velocity.x, 0, SPEED)
		velocity.z = 0.0 #move_toward(velocity.z, 0, SPEED)

	#bob
	var pos = Vector3.ZERO
	time += delta * velocity.length() * float(is_on_floor())
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	camera.transform.origin = pos
	
	move_and_slide()
