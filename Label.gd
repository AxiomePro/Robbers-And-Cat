extends Control

@onready var money_label = $Money
@onready var objects_label = $Objects

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	money_label.text = "Argent: %d" % Global.money
	objects_label.text = "Tableaux Volés: %d" % Global.objects
