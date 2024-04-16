extends StaticBody3D

var interactable = true

func _ready():
	pass

func interact():
	if interactable == true and Global.objects_got >= Global.objects_needed:
		interactable = false
		Global.objects += Global.objects_got - Global.objects_needed
		get_tree().change_scene_to_file("res://Menu/win.tscn")
