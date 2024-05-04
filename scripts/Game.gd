extends Node2D

var flashlight = load("res://assets/flashlight.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_custom_mouse_cursor(flashlight)
	else:
		Input.set_custom_mouse_cursor(null)
		
