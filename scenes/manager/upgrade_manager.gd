extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var xp_manager: ExperienceManager

# key = upgrade id
var current_upgrades = {}


func _ready():
	xp_manager.level_up.connect(on_level_up)
	
	
func on_level_up(current_level: int):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
		
	if !current_upgrades.has(chosen_upgrade.id):
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[chosen_upgrade.id]["quantity"] += 1
	
	print(current_upgrades)
