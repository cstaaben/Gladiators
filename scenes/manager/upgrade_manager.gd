extends Node

@export var xp_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

# key = upgrade id
var current_upgrades = {}
var upgrade_pool: WeightedTable = WeightedTable.new()

var upgrade_axe_ability = preload("res://resources/upgrades/upgrade_axe_ability.tres")
var upgrade_axe_damage = preload("res://resources/upgrades/upgrade_axe_damage.tres")
var upgrade_sword_speed = preload("res://resources/upgrades/upgrade_sword_rate.tres")
var upgrade_sword_damage = preload("res://resources/upgrades/upgrade_sword_damage.tres")
var upgrade_player_speed = preload("res://resources/upgrades/upgrade_player_speed.tres")
var upgrade_anvil_ability = preload("res://resources/upgrades/upgrade_anvil_ability.tres")
var upgrade_anvil_count = preload("res://resources/upgrades/upgrade_anvil_count.tres")


func _ready():
	upgrade_pool.add_item(upgrade_axe_ability, 10)
	upgrade_pool.add_item(upgrade_anvil_ability, 10)
	upgrade_pool.add_item(upgrade_sword_speed, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	upgrade_pool.add_item(upgrade_player_speed, 5)
	
	xp_manager.level_up.connect(_on_level_up)
	
	
func apply_upgrade(upgrade: AbilityUpgrade):
	if !current_upgrades.has(upgrade.id):
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
		
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)
		
	update_upgrade_pool(upgrade)
	GameEvents.ability_upgrade_added.emit(upgrade, current_upgrades)
	
	
func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	match chosen_upgrade.id:
		upgrade_axe_ability.id:
			upgrade_pool.add_item(upgrade_axe_damage, 10)
		upgrade_anvil_ability.id:
			upgrade_pool.add_item(upgrade_anvil_count, 5)



func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	for i in 2:
		if chosen_upgrades.size() == upgrade_pool.items.size():
			break
			
		var upgrade = upgrade_pool.random_item(chosen_upgrades) as AbilityUpgrade
		chosen_upgrades.append(upgrade)
		
	return chosen_upgrades


func _on_level_up(_current_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)


func _on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
