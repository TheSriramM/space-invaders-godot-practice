extends CharacterBody2D

@export var health = 1000
@export var damage = 200
const max_red_count = 2
var cur_red_count = 0
var red_enemy = preload("res://Scenes/Enemies/red_enemy.tscn")
var rnx_pos = RandomNumberGenerator.new()
var speed = 1
var close_damage
var move_forward = false
var next_to_spaceship = false

func _ready():
	if get_parent().get_parent().red_enemy_def == 0:
		$red_enemies_timer.start()
	else:
		move_forward = true
		cur_red_count += 1
	scale = Vector2(0.9, 0.9)
	position = Vector2(rnx_pos.randi_range(100, 700), -100)
	$r_enemy_area.add_to_group("red_enemies")
	$"lasers/1_bullet_pos/1_enemy_laser/area_col".add_to_group("red_enemy_laser")
	$"lasers/2_bullet_pos/2_enemy_laser/area_col".add_to_group("red_enemy_laser")
	$explosion.hide()
	
func _physics_process(_delta: float) -> void:
	if move_forward:
		velocity.y += speed
		move_and_slide()

func _got_hit_by_player():
	position.y -= 10
	damage = get_parent().get_parent().damage
	if next_to_spaceship:
		close_damage = damage + 100
		health -= close_damage
	else:
		health -= damage
	if health <= 0:
		$explosion.show()
		$explosion.play("explosion")
		$explosion/explosion_sound.play()
		$get_smaller.play("get_smaller")
		$queue_free.start()

func _on_r_enemy_area_area_entered(area: Area2D) -> void:
	if move_forward:
		#above if statement checks if the red enemy has started moving
		if "player_laser" in area.get_groups():
			_got_hit_by_player()
		if "spaceship" in area.get_groups():
			next_to_spaceship = true
			if next_to_spaceship == false:
				_got_hit_by_player()


func _on_queue_free_timeout() -> void:
	queue_free()
	get_parent().get_parent().score += 100
	get_parent().get_parent().red_enemy_def += 1
	if get_parent().get_parent().boss == false:
		var instance = red_enemy.instantiate()
		instance.add_to_group("red_enemies")
		get_parent().add_child(instance)


func _on_screen_screen_exited() -> void:
	get_parent().get_parent().red_enemy_def += 1
	get_parent().get_parent().planet_health -= 500
	if get_parent().get_parent().boss == false:
		var instance = red_enemy.instantiate()
		instance.add_to_group("red_enemies")
		get_parent().add_child(instance)
		queue_free()


func _on_red_enemies_timer_timeout() -> void:
	move_forward = true
	get_parent().get_parent().wave_no += 1
