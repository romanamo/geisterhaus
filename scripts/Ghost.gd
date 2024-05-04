extends AnimatedSprite2D


@onready var overlay : Sprite2D =  $"../BlackOverlay"
@onready var overlay_size : Vector2 = overlay.texture.get_size() * overlay.scale

# Ghost moving speed
@export var speed : Vector2 = Vector2(2.5, 2.5)
@export var SIGHT : float = 2.75

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Retrieve current texture
	var current_animation : String = self.animation
	var sprite_size : Vector2 = self.sprite_frames.get_frame_texture(current_animation, 0).get_size()
	var sprite_center : Vector2 = self.position + sprite_size/2
	
	# Turn if not on black spots using calculated lookahead vector
	var lookahead = (sprite_center + speed.normalized() * sprite_size * SIGHT).clamp(Vector2i.ZERO, get_window().size)
	
	if is_uncovered(Vector2(lookahead.x, position.y)):
		speed.x *= -1
	if is_uncovered(Vector2(position.x, lookahead.y)):
		speed.y *= -1
	
	# Update speed according to pos and overlay size
	if (position.x + sprite_size.x >= overlay_size.x) or (position.x <= 0):
		speed.x = -speed.x
		self.flip_h = !self.flip_h # change sprite direction
	if (position.y + sprite_size.y >= overlay_size.y) or (position.y <= 0):
		speed.y = -speed.y
	
	
		
	# Stop if player uncovers sprite
	if is_uncovered(position):
		speed = Vector2.ZERO
	# Update position
	position += Vector2(speed.x, speed.y)
	
	

func is_uncovered(pos: Vector2) -> bool:
	return overlay.mask_image.get_pixelv(Vector2i(pos/overlay.scale)).a8 == 0
