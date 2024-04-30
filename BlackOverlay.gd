extends Sprite2D

var brush_size = 50  
var mask_image: Image
var mask_texture: ImageTexture

func _ready():
	mask_image = Image.create(texture.get_width(), texture.get_height(), false, Image.FORMAT_RGBA8)
	mask_image.fill(Color(0, 0, 0, 1))  # Standardzustand
	update_texture()  

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_global_mouse_position()
		update_image(mouse_pos, true)
		update_texture()

func update_image(pos: Vector2, erase: bool):
	# Mausposition konvertieren
	var local_pos = to_local(pos)

	# Betroffene Area berechnen
	var start_x = max(0, int(local_pos.x - brush_size))
	var end_x = min(mask_image.get_width(), int(local_pos.x + brush_size))
	var start_y = max(0, int(local_pos.y - brush_size))
	var end_y = min(mask_image.get_height(), int(local_pos.y + brush_size))

	for x in range(start_x, end_x):
		for y in range(start_y, end_y):
			if Vector2(x, y).distance_to(local_pos) <= brush_size:
				mask_image.set_pixel(x, y, Color(0, 0, 0, 0))  # Bild transparent setzen

func update_texture():
	if not mask_image.is_empty():
		mask_texture = ImageTexture.create_from_image(mask_image)
		self.texture = mask_texture
	else:
		print("Error: Image is empty")
