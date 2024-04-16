func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_key_pressed(KEY_E) and event.pressed == true:
			print("Pressed Left Mouse Button")
