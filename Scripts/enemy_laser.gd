extends Sprite2D

func _ready() -> void:
	global_position = get_parent().global_position
	scale = Vector2(0.2, 0.2)

# This function is called at every frame
func _process(_delta):
	# translate is used to move any node using a vector as an input
	if "r_enemy_area" in get_parent().get_parent().get_parent().get_child(3).name:
		#if the laser's parent is a red enemy
		if get_parent().get_parent().get_parent().move_forward:
			show()
			global_position.y += 3
	elif "orange_enemy_area" in get_parent().get_parent().get_parent().get_child(3).name:
		if get_parent().get_parent().get_parent().move_forward:
			show()
			global_position.y += 3
	else:
		show()
		global_position.y += 3



func _on_disappear_screen_exited() -> void:
	hide()
	global_position = get_parent().global_position


func _on_area_col_area_entered(area: Area2D) -> void:
	pass
