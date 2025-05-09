extends TextureRect

@onready var more_lasers = $upgrades/vertical_buttons/more_lasers
@onready var more_damage = $upgrades/vertical_buttons/more_damage
@onready var more_ = $upgrades/vertical_buttons/more_hp
var boss_scene = preload("res://Scenes/Enemies/boss.tscn")
var damage = 100
var hp = 2000
var wave_no = 1
var score = 0
var planet_health = 10000
var red_enemy_def = 0
var orange_enemy_def = 0
var more_lasers_cost = [250, 1000]
var more_damage_cost = [50, 100, 200, 400, 800, 1500, 3000]
var more_hp_cost = [50, 100, 200, 400, 800, 1500, 3000]
var health_increase = [200, 400, 800, 1000]
var more_lasers_index = 0
var more_damage_index = 0
var more_hp_index = 0
var health_increase_index = 0
var boss = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$health_text.text = str(hp)
	damage = $spaceship.player_damage
	score = $spaceship.score
	$left_boss_area.add_to_group("left_boss_area")
	$right_boss_area.add_to_group("right_boss_area")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	damage = $spaceship.player_damage
	hp = $spaceship.health
	$health_text.text = str(hp)
	$score.text = "Score: " + str(score)
	$spaceship.more_lasers_index = more_lasers_index
	if hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/UI/u_died.tscn")
	if hp <= 500:
		# Change the colour to red if the hp is less than 500
		$health_text.add_theme_color_override("font_color", Color(1, 0, 0, 1))
	else:
		# Change the colour back to white if the hp is greater than 500
		$health_text.add_theme_color_override("font_color", Color(1, 1, 1, 1))

func _on_boss_timer_timeout() -> void:
	boss = true
	var game_boss = boss_scene.instantiate()
	add_child(game_boss)
