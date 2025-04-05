extends CharacterBody2D

@export var max_speed = 400
@export var accel = 1500
@export var health = 2000
@export var heal = 200
var more_lasers = [200, 500, 1000]
var more_damage = [50, 100, 200, 400, 800, 1500, 3000]
var more_hp = [50, 100, 200, 400, 800, 1500, 3000]
var more_lasers_index = 0
var score = 0
var player_damage = 100
var can_shoot = true
var enemy_contact = 0
var enemy_damage = 100

@onready var player_laser = $player_laser

func _ready() -> void:
	$player_laser.hide()
	$spaceship_area.add_to_group("spaceship")

func _physics_process(delta):
	# Update velocity towards the desired direction based on input
	velocity = velocity.move_toward(Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * max_speed, accel * delta)
	# Move the character
	move_and_slide()
	if Input.is_action_pressed("shoot"):
		if can_shoot:
			_shoot()
			$cooldown.start()
			can_shoot = false
	
func _shoot():
	var b = player_laser.duplicate()
	var b_area = $player_laser/area_col.duplicate()
	get_parent().add_child(b)
	b.add_child(b_area)
	b_area.add_to_group("player_laser")
	b.global_position = $bullet_pos.global_position
	b.visible = true
	enemy_contact = 0
	if more_lasers_index >= 1:
		var b2 = player_laser.duplicate()
		var b2_area = $player_laser/area_col.duplicate()
		get_parent().add_child(b2)
		b2.add_child(b2_area)
		b2_area.add_to_group("player_laser")
		b2.global_position = $bullet_pos2.global_position
		b2.visible = true
		enemy_contact = 0
		if more_lasers_index == 2:
			var b3 = player_laser.duplicate()
			var b3_area = $player_laser/area_col.duplicate()
			get_parent().add_child(b3)
			b3.add_child(b3_area)
			b3_area.add_to_group("player_laser")
			b3.global_position = $bullet_pos3.global_position
			b3.visible = true
			enemy_contact = 0



func _on_cooldown_timeout() -> void:
	can_shoot = true
	
func _got_hit():
	health -= enemy_damage


func _on_spaceship_area_another_area_entered(area: Area2D) -> void:
	#add damage if the area is laser area
	if "grey_enemy_laser" in area.get_groups():
		enemy_damage = 100
		_got_hit()
		#star the heal timer
		$heal.start()
	if "grey_enemy" in area.get_groups():
		$damage_cooldown.start()
	if "red_enemy_laser" in area.get_groups():
		enemy_damage = 150
		_got_hit()
		$heal.start()
	if "red_enemy" in area.get_groups():
		$damage_cooldown.start()

func _on_damage_cooldown_timeout() -> void:
	#if the player has been in contact with the enemy less than 1 time
	if enemy_contact < 1:
		enemy_damage = 50
		_got_hit()
		enemy_contact += 1
	else:
		enemy_damage = 100
	
func _on_heal_timeout() -> void:
	health += heal
