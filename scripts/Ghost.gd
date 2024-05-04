extends AnimatedSprite2D


@onready var overlay : Sprite2D =  $"../BlackOverlay"
@onready var overlay_size : Vector2 = overlay.texture.get_size() * overlay.scale

# Ghost moving speed
@export var speed : Vector2 = Vector2(2.5, 2.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Retrieve current texture
	
	var current_animation : String = self.animation
	var sprite_size : Vector2 = self.sprite_frames.get_frame_texture(current_animation, 0).get_size()
	
	# Update speed
	if (position.x + sprite_size.x >= overlay_size.x) or (position.x <= 0):
		speed.x = -speed.x
		self.flip_h = !self.flip_h
	if (position.y + sprite_size.y >= overlay_size.y) or (position.y <= 0):
		speed.y = -speed.y
	
	var sprite_center : Vector2 = self.position + sprite_size/2
	
	print(self.position)
	print(overlay.mask_image.get_pixelv(Vector2i(sprite_center)).a8)
	
	if overlay.mask_image.get_pixelv(Vector2i(sprite_center)).a8 == 0:
		speed = Vector2.ZERO
	
	# Update position
	position += Vector2(speed.x, speed.y)
	
	
