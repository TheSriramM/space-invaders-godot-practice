extends CharacterBody2D

@export var health = 5000
@export var damage = 500
var orange_enemy = preload("res://Scenes/Enemies/orange_enemy.tscn")
var rnx_pos = RandomNumberGenerator.new()
var speed = 1
var move_forward = false
var next_to_spaceship = false
var close_damage


func _ready() -> void:
	if get_parent().get_parent().orange_enemy_def == 0:
		$or_en_timer.start()
		print("timer started")
	else:
		move_forward = true
	rotation_degrees = 180
	position = Vector2(rnx_pos.randi_range(100, 700), -130)
	$or_enemy_area.add_to_group("orange_enemy_area")
	$lasers/laser_1_pos/enemy_laser1.add_to_group("orange_enemy_laser")
	$lasers/laser_1_pos2/enemy_laser2.add_to_group("orange_enemy_laser")
	$lasers/laser_1_pos3/enemy_laser3.add_to_group("orange_enemy_laser")
	$explosion.hide()

func _physics_process(delta: float) -> void:
	if move_forward:
		velocity.y += speed
		move_and_slide()

func _got_hit_by_player():
	position.y -= 5
	damage = get_parent().get_parent().damage
	if next_to_spaceship:
		close_damage = damage + 500
		health -= close_damage
	else:
		health -= damage
	if health <= 0:
		$explosion.show()
		$explosion.play("explosion")
		$explosion/explosion_sound.play()
		$queue_free.start()

func _on_orange_enemy_timer_timeout() -> void:
	move_forward = true
	


func _on_orange_enemy_area_entered(area: Area2D) -> void:
	if move_forward:
		if "player_laser" in area.get_groups():
			_got_hit_by_player()
		if "spaceship" in area.get_groups():
			next_to_spaceship = true
			_got_hit_by_player()


func _on_queue_free_timeout() -> void:
	queue_free()
	get_parent().get_parent().score += 300
	get_parent().get_parent().orange_enemy_def += 1
	if get_parent().get_parent().boss == false:
		var instance = orange_enemy.instantiate()
		instance.add_to_group("orange_enemies")
		get_parent().add_child(instance)


func _on_screen_screen_exited() -> void:
	get_parent().get_parent().planet_health -= 1000
	queue_free()
	get_parent().get_parent().orange_enemy_def += 1
	if get_parent().get_parent().boss == false:
		var instance = orange_enemy.instantiate()
		instance.add_to_group("orange_enemies")
		get_parent().add_child(instance)
