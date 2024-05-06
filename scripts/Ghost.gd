extends AnimatedSprite2D


@onready var overlay : Sprite2D =  $"../../BlackOverlay"
@onready var overlay_size : Vector2 = overlay.texture.get_size() * overlay.scale
@onready var poof_player = get_node("PoofSound")
@onready var poof_pfad = $PoofSound
# Ghost moving speed
@export var speed : Vector2 = Vector2(0,0)
@export var SIGHT : float = 2.75
@export var caught : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Retrieve current texture measures
	var sprite_size = get_size()
	var sprite_center : Vector2 = get_center()
		
	if not caught:
		if overlay.uncovered(sprite_center):
			caught = true
			poof_pfad.play()
		# Turn if not on black spots using calculated lookahead vector
		var lookahead = (sprite_center + speed.normalized() * sprite_size * SIGHT).clamp(Vector2.ZERO, overlay_size-Vector2(1,1))
		
		# Update speed according to pos and overlay size
		if (position.x + sprite_size.x >= overlay_size.x) or (position.x <= 0) or overlay.uncovered(Vector2(lookahead.x, sprite_center.y)):
			speed.x *= -1
			self.flip_h = !self.flip_h # change sprite direction
		if (position.y + sprite_size.y >= overlay_size.y) or (position.y <= 0) or overlay.uncovered(Vector2(sprite_center.x, lookahead.y)):
			speed.y *= -1
			
		# Update position
		position += Vector2(speed.x, speed.y) * delta * 60
	
	
	
	
		
		
func get_center(sprite_size: Vector2=get_size()):
	return self.position + sprite_size/2
	
func get_size():
	var current_animation : String = self.animation
	return self.sprite_frames.get_frame_texture(current_animation, 0).get_size()
