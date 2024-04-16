extends StaticBody3D

var interactable = true

func _ready():
	Global.objects_needed = 2.0
	Global.objects_got = 0.0

func interact():
	if interactable == true and Global.objects_got >= Global.objects_needed:
		interactable = false
		Global.objects += Global.objects_got - Global.objects_needed
		get_tree().change_scene_to_file("res://Game.tscn")
