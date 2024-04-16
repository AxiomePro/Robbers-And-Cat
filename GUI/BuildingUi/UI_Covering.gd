extends Node3D

@onready var spray = $AudioStreamPlayer
@onready var select = $Select
@onready var audio = $"../../car/AudioStreamPlayer"
@onready var audio2 = $"../../car/AudioStreamPlayer2"
@onready var jaune = $"../../car/CubeYellow"
@onready var vert = $"../../car/CubeGreen"
@onready var bleu = $"../../car/CubeBlue"

var paused = false

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

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Global.money >= 250.0:
		select_menu()

func _change_color(color):
	spray.playing = true
	Global.money -= 250.0
	jaune.hide()
	vert.hide()
	bleu.hide()
	color.show()
	select_menu()

func _on_jaune_pressed():
	_change_color(jaune)

func _on_vert_pressed():
	_change_color(vert)

func _on_bleu_pressed():
	_change_color(bleu)	

func _on_reprendre_pressed():
	select_menu()
