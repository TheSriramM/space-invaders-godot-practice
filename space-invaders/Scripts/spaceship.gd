extends CharacterBody2D

@export var max_speed = 400
@export var accel = 1500
@export var health = 1000
@export var heal = 200
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
