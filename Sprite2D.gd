extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.01)
	tween.chain().tween_property(self, "modulate", Color.BLACK, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
