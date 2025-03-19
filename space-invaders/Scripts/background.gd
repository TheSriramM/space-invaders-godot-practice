extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$health_text.text = "Healh: " + str($spaceship.health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$health_text.text = "Healh: " + str($spaceship.health)
