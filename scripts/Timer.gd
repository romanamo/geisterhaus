extends Timer

@onready var time_label : Label = $"../TimeLabel"
# Called when the node enters the scene tree for the first time.
func _ready():
	self.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_label.set_text(str(floor(self.time_left)))
