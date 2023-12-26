extends Node

const _UPGRADES_KEY = "upgrades"
const _TOTAL_XP_KEY = "total_xp"
const _QUANTITY_KEY = "quantity"
const SAVE_PATH 	= "user://game.sav"

var _meta_data: Dictionary = {
	_TOTAL_XP_KEY: 0,
	_UPGRADES_KEY: {},
}

func _ready():
	GameEvents.xp_vial_collected.connect(_on_xp_collected)
	load_data()


func load_data():
	if !FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	_meta_data = file.get_var()


func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(_meta_data)


func add_meta_upgrade(upgrade: MetaUpgrade):
	if !_meta_data[_UPGRADES_KEY].has(upgrade.id): 
		_meta_data[_UPGRADES_KEY][upgrade.id] = {_QUANTITY_KEY: 0}
	_meta_data[_UPGRADES_KEY][upgrade.id][_QUANTITY_KEY] += 1


func _on_xp_collected(number: float):
	_meta_data[_TOTAL_XP_KEY] += number
