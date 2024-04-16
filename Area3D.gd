extends Area3D

@onready var select = $"../Select"
@onready var main = $"../"
@onready var audio = $"../../../car/AudioStreamPlayer"
@onready var audio2 = $"../../../car/AudioStreamPlayer2"

var paused = false
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	pass

func _process(delta):
	pass

func select_menu():
	if paused:
		select.hide()
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Engine.time_scale = 0.001
		select.show()
		audio.playing = false
		audio2.playing = false
	paused = !paused

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	select_menu()

func _on_braquer_pressed():
	select_menu()
	main.change_scene()

func _on_reprendre_pressed():
	select_menu()
