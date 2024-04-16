extends Control

var seconds = 45.0
var minutes = 0.0

@onready var objects_label = $Objects
@onready var time_label = $Time

# Called when the node enters the scene tree for the first time.
func _ready():
	# Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	objects_label.text = "Objects Stolen: %d" % Global.objects_got

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_timer_timeout():
	var zero = ""
	if seconds == 0.0:
		if minutes > 0.0:
			minutes -= 1.0
			seconds = 60.0
	if seconds != 0.0:
		seconds -= 1.0
	else:
		get_tree().change_scene_to_file("res://Game.tscn")
	if seconds < 10.0:
		zero = "0"
	time_label.text = "Time left: %d:%s%d" % [minutes, zero, seconds]
