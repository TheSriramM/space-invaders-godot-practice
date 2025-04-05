extends CharacterBody2D

@export var health = 500
var grey_enemy = preload("res://Scenes/Enemies/grey_enemy.tscn")
var rnx_pos = RandomNumberGenerator.new()
var damage = 100
var can_shoot = true
var spawn_new_enemy = false
var enemy_no = 3
var wave_1_complete = false
var next_to_spaceship_count = 0
var beg_pos : Vector2
#no of enemies defeated
var grey_enemy_def = 0

func _ready() -> void:
	rnx_pos.randomize()
	beg_pos = global_position
	$enemy_laser.hide()
	$area_col.add_to_group("grey_enemies")
	$explosion.hide()
	$enemy_laser/area_col.add_to_group("grey_enemy_laser")
	damage = get_parent().get_parent().damage
	if is_in_group("grey_enemies"):
		global_position = Vector2(beg_pos.x + rnx_pos.randi_range(100, 700), beg_pos.y)
	
	

func _physics_process(_delta: float) -> void:
	velocity.y += 1
	move_and_slide()
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	get_parent().get_parent().score += 30
	grey_enemy_def += 1
	var instance = grey_enemy.instantiate()
	instance.add_to_group("grey_enemies")
	get_parent().add_child(instance)
	
func _got_hit_by_player():
	health -= damage
	global_position.y -= 20
	if health <= 0:
		#play the explosion animation
		$explosion.visible = true
		$explosion.play("explosion")
		$get_smaller.play("shrink")
		$explosion/explosion_sound.play()
		$queue_free.start()
	

func _on_cooldown_timeout() -> void:
	can_shoot = true


func _on_area_col_area_entered(area: Area2D) -> void:
	if "player_laser" in area.get_groups():
		if health > 0:
			_got_hit_by_player()
	if "spaceship" in area.get_groups():
		next_to_spaceship_count += 1
		damage += 50
		if next_to_spaceship_count <= 1:
			_got_hit_by_player()
		else:
			$explosion.show()
			$explosion.play("explosion")
			$explosion/explosion_sound.play()
			$get_smaller.play("shrink")
			$queue_free.start()


func _on_queue_free_timeout() -> void:
	queue_free()
	get_parent().get_parent().score += 30
	grey_enemy_def += 1
	var instance = grey_enemy.instantiate()
	instance.add_to_group("grey_enemies")
	get_parent().add_child(instance)
	
