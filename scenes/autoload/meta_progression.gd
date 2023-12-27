extends Node

const UPGRADES_KEY = "upgrades"
const TOTAL_XP_KEY = "total_xp"
const QUANTITY_KEY = "quantity"
const SAVE_PATH 	= "user://game.save"

var meta_data: Dictionary = {
	TOTAL_XP_KEY: 0,
	UPGRADES_KEY: {},
}

func _ready():
	GameEvents.xp_vial_collected.connect(_on_xp_collected)
	load_data()


func load_data():
	if !FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	meta_data = file.get_var()


func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(meta_data)


func add_meta_upgrade(upgrade: MetaUpgrade):
	if !meta_data[UPGRADES_KEY].has(upgrade.id): 
		meta_data[UPGRADES_KEY][upgrade.id] = {QUANTITY_KEY: 0}

	meta_data[UPGRADES_KEY][upgrade.id][QUANTITY_KEY] += 1
	save_data()


func _on_xp_collected(number: float):
	meta_data[TOTAL_XP_KEY] += number
