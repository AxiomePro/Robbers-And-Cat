extends Node3D

@onready var cashout = $AudioStreamPlayer

var seconds = 0.0
var clock = seconds
var is_selling = false

func _ready():
	pass

func _process(delta):
	if is_selling and Global.objects == 0.0:
		is_selling = false
	elif is_selling and clock != seconds:
		cashout.playing = true
		Global.money += 150
		Global.objects -= 1.0
		clock = seconds

func _on_timer_timeout():
	seconds += 1.0

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	is_selling = true
	clock = seconds
