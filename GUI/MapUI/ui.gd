extends Control

@onready var ui = $"../Area3D"
@onready var node = $"../"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_braquer_pressed():
	ui.select_menu()
	node.change_scene()

func _on_reprendre_pressed():
	ui.select_menu()
