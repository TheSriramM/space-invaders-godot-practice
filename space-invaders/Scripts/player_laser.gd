extends Sprite2D


# This function is called at every frame
func _process(delta):
	# translate is used to move any node using a vector as an input
	translate(Vector2(0,-1) * 1000 * delta)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# deleting the bullet from the game
	queue_free()


func _on_player_laser_enter_enemy(area: Area2D) -> void:
	if "grey_enemy" in area.get_groups():
		hide()
