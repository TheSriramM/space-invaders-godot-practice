extends CharacterBody2D

@export var health = 5000
@export var damage = 500
var shoot_pos = false
var move_right = false
var move_left = false
var horizontal = false

const HORIZONTAL_SPEED = 200
const DOWN_SPEED = 100

func _ready() -> void:
	global_position = Vector2(490, -100)
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Always reset velocity at the start of the frame
	velocity = Vector2.ZERO
	
	if not horizontal:
		# Moving down until reaching y = 300
		if position.y < 300:
			velocity.y = DOWN_SPEED
		else:
			shoot_pos = true
			horizontal = true
	else:
		# Horizontal movement
		if move_left:
			velocity.x = -HORIZONTAL_SPEED
		elif move_right:
			velocity.x = HORIZONTAL_SPEED
		else:
			velocity.x = -HORIZONTAL_SPEED  # default to left if neither is set (initial movement)

	move_and_slide()

	if shoot_pos:
		shoot()

func shoot():
	pass

func _on_area_entered(area: Area2D) -> void:
	print(area.get_groups())
	if "left_boss_area" in area.get_groups():
		move_right = true
		move_left = false
	elif "right_boss_area" in area.get_groups():
		move_left = true
		move_right = false
