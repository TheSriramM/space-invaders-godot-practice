extends CharacterBody2D

@export var health = 5000
@export var damage = 500
var boss_bullet = preload("res://Scenes/boss_bullet.tscn")

const HORIZONTAL_SPEED = 200
const DOWN_SPEED = 100
const TARGET_Y = 200

var moving_right = false
var is_horizontal = false

func _ready() -> void:
	$boss_area.add_to_group("boss")
	global_position = Vector2(490, -100)
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO

	if not is_horizontal:
		if position.y < TARGET_Y:
			velocity.y = DOWN_SPEED
		else:
			global_position.y = TARGET_Y  # Snap to target position
			velocity = Vector2.ZERO
			is_horizontal = true
	else:
		velocity.y = 0  # Ensure vertical movement is off

		if moving_right:
			velocity.x = HORIZONTAL_SPEED
		else:
			velocity.x = -HORIZONTAL_SPEED

	move_and_slide()



func _on_area_entered(area: Area2D) -> void:
	var groups = area.get_groups()
	if "left_boss_area" in groups:
		moving_right = true
	elif "right_boss_area" in groups:
		moving_right = false
	if "player_laser" in area.get_groups():
		health -= get_parent().damage
		if health <= 0:
			get_tree().change_scene_to_file("res://Scenes/UI/u_won.tscn")
