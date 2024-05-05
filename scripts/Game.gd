extends Node2D

@onready var ghosts : Node = %Enemies
@onready var overlay : Sprite2D = $BlackOverlay

@export var level: int = 1
@export var spawn_inlay : float = 0.5 # in Interval [0;1]

var rng = RandomNumberGenerator.new()
var Ghost = preload("res://ghost.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_level(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if found_all_ghosts():
		level += 1
		overlay.reset()
		start_level(level)

func start_level(progress: int):
	self.clear_ghosts()
	self.initialize_ghosts(progress)
	
func clear_ghosts():
	for ghost in ghosts.get_children():
		ghosts.remove_child(ghost)
		ghost.queue_free()

func found_all_ghosts() -> bool:
	for ghost in ghosts.get_children():
		if not overlay.uncovered(ghost.get_center()):
			return false 
	return true
	
func initialize_ghosts(progress: int):
	rng.state = progress
	
	for i in range(amount_ghosts(progress)):
		var ghost = Ghost.instantiate()
		
		# Initialize ghost attributes 
		var overlay_size = Vector2(overlay.texture.get_size() * overlay.scale)
		ghost.speed = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized() * min(6, sqrt(progress+1))
		ghost.position = Vector2(rng.randf(), rng.randf()) * overlay_size * spawn_inlay + overlay_size * (1 - spawn_inlay)/2
		
		# Add ghost to tree
		ghosts.add_child(ghost)

func amount_ghosts(progress: int):
	return floor(1.3 * sqrt(progress) + cos(progress)**2)
