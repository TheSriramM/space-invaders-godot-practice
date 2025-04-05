extends TextureRect

@onready var more_lasers = $upgrades/vertical_buttons/more_lasers
@onready var more_damage = $upgrades/vertical_buttons/more_damage
@onready var more_ = $upgrades/vertical_buttons/more_hp
var damage = 100
var hp = 2000
var score = 0
var planet_health = 10000
var red_enemy_def = 0
var more_lasers_cost = [200, 500, 1000]
var more_damage_cost = [50, 100, 200, 400, 800, 1500, 3000]
var more_hp_cost = [50, 100, 200, 400, 800, 1500, 3000]
var health_increase = [200, 400, 800, 1000]
var more_lasers_index = 0
var more_damage_index = 0
var more_hp_index = 0
var health_increase_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$health_text.text = "Health: " + str(hp)
	damage = $spaceship.player_damage
	score = $spaceship.score
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hp = $spaceship.health
	$health_text.text = "Health: " + str(hp)
	$score.text = "Score: " + str(score)
