extends Node3D

var interactable = true

func interact():
	if interactable == true:
		interactable = false
		Global.objects_got += 1
		hide()
