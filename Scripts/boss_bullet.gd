extends CharacterBody2D

func _ready() -> void:
	$bullet_area.add_to_group("boss_bullet")
	$explosion.pause()
	$explosion.hide()
	$boss_bullet.show()
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += 2 
	move_and_slide()

func _on_screen_screen_exited() -> void:
	var boss_position = get_parent().get_child(5).global_position
	global_position = boss_position
	
	$explosion.hide()
	$boss_bullet.show()

func _on_bullet_area_entered(area: Area2D) -> void:
	if "spaceship" in area.get_groups():
		$boss_bullet.hide()
		$explosion.show()
		$explosion.play("explosion")
