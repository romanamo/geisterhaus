extends Node2D

@onready var ghosts : Node = %Enemies
@onready var overlay : Sprite2D = $BlackOverlay
@onready var timer : Timer = $Timer
@onready var level_label = $LevelLabel
#Test zum erstellen einer Playlist die den ersten Song abspielt
@onready var audio_player = AudioStreamPlayer.new()
@onready var poof_player = get_node("Audio/Poof")
@export var level: int = 1
@export var spawn_inlay : float = 0.5 # in Interval [0;1]

var rng = RandomNumberGenerator.new()
var Ghost = preload("res://ghost.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_level(level)
	timer.start(5)


	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if found_all_ghosts():
		level += 1
		start_level(level)
		timer.start(min(12, 5 + timer.time_left))
		
func _on_timer_timeout():
	level = 1
	start_level(level)
	timer.start(5)
	
func start_level(progress: int):
	overlay.reset()
	overlay.animate_fade()
	self.clear_ghosts()
	level_label.set_text("Level: " + str(progress))
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
	
#Funktion damit eine Playlist abgespielt wird	
#func play_next_song():
	#var song_path = "res://sfx/geisterhaus_theme_mit_Anfang.ogg"
	#var song = load(song_path)
	#var next_song_path = "res://sfx/geisterhaus_theme_mitte.ogg"
	#var next_song = load(next_song_path)
	#if(!audio_player.stream != null):
		#audio_player.stream = next_song
		#
		#audio_player.play
	#else:
		#audio_player.stream = song
		#audio_player.play
