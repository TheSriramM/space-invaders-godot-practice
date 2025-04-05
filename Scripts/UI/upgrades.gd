extends Control

func _ready() -> void:
	$vertical_buttons/more_lasers.text = str("More lasers: ") + str(get_parent().more_lasers_cost[get_parent().more_lasers_index])
	$vertical_buttons/more_damage.text = str("More damage: ") + str(get_parent().more_damage_cost[get_parent().more_damage_index])
	$vertical_buttons/more_hp.text = str("More HP: ") + str(get_parent().more_hp_cost[get_parent().more_hp_index])
	
func _on_more_lasers_pressed() -> void:
	if get_parent().score > get_parent().more_lasers_cost[get_parent().more_lasers_index]:
		get_parent().score -= get_parent().more_lasers_cost[get_parent().more_lasers_index]
		get_parent().more_lasers_index += 1
		get_parent().get_child(2).more_lasers_index += 1
		$vertical_buttons/more_lasers.text = str("More lasers: ") + str(get_parent().more_lasers_cost[get_parent().more_lasers_index])

func _on_more_damage_pressed() -> void:
	if get_parent().score > get_parent().more_damage_cost[get_parent().more_damage_index]:
		get_parent().score -= get_parent().more_damage_cost[get_parent().more_damage_index]
		get_parent().more_damage_index += 1
		get_parent().damage *= 2
		$vertical_buttons/more_damage.text = str("More damage: ") + str(get_parent().more_damage_cost[get_parent().more_damage_index])
	else:
		print("cannot buy")


func _on_more_hp_pressed() -> void:
	if get_parent().score > get_parent().more_hp_cost[get_parent().more_hp_index]:
		get_parent().score -= get_parent().more_hp_cost[get_parent().more_hp_index]
		get_parent().more_hp_index += 1
		if get_parent().more_hp_index <= 3: 
			get_parent().get_child(2).health += get_parent().health_increase[get_parent().health_increase_index]
			get_parent().get_child(2).heal += 100
			$vertical_buttons/more_hp.text = str("More hp: ") + str(get_parent().more_hp_cost[get_parent().more_hp_index])
		else:
			get_parent().get_child(2).health += 1000
			$vertical_buttons/more_hp.text = str("More hp: ") + str(get_parent().more_hp_cost[get_parent().more_hp_index])
	else:
		print("cannot buy")
