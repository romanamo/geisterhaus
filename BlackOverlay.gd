extends Sprite2D

func _process(delta):
	var mat = material as ShaderMaterial  # Cast the material to ShaderMaterial
	if mat:  # Check if the material is correctly cast
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			mat.set_shader_parameter("erase", true)
			mat.set_shader_parameter("erase_center", get_global_mouse_position())
		else:
			mat.set_shader_parameter("erase", false)
