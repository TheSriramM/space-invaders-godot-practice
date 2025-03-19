extends Sprite2D

func _ready() -> void:
	$area_col.add_to_group("grey_enemy_laser")

# This function is called at every frame
func _process(_delta):
	# translate is used to move any node using a vector as an input
	show()
	global_position.y += 2



func _on_disappear_screen_exited() -> void:
	hide()
	global_position = get_parent().global_position
