extends Node

const _UPGRADES_KEY = "upgrades"
const _TOTAL_XP_KEY = "total_xp"
const _QUANTITY_KEY = "quantity"
const _SAVE_PATH 	= "user://game.save"

var _meta_data: Dictionary = {
	_TOTAL_XP_KEY: 0,
	_UPGRADES_KEY: {},
}

var total_xp: float = 0:
	set(v):
		if v < 0:
			_meta_data[_TOTAL_XP_KEY] = 0
		_meta_data[_TOTAL_XP_KEY] += v
	get:
		return _meta_data[_TOTAL_XP_KEY]

func _ready():
	GameEvents.xp_vial_collected.connect(_on_xp_collected)
	load_data()


func load_data():
	if !FileAccess.file_exists(_SAVE_PATH):
		return
	
	var file = FileAccess.open(_SAVE_PATH, FileAccess.READ)
	_meta_data = file.get_var()


func save_data():
	var file = FileAccess.open(_SAVE_PATH, FileAccess.WRITE)
	file.store_var(_meta_data)


func add_meta_upgrade(upgrade: MetaUpgrade):
	if !_meta_data[_UPGRADES_KEY].has(upgrade.id): 
		_meta_data[_UPGRADES_KEY][upgrade.id] = {_QUANTITY_KEY: 0}

	_meta_data[_UPGRADES_KEY][upgrade.id][_QUANTITY_KEY] += 1
	save_data()


func get_upgrades():
	return _meta_data[_UPGRADES_KEY]


func get_upgrade_quantity(id: String):
	if !_meta_data[_UPGRADES_KEY].has(id):
		return 0
	return _meta_data[_UPGRADES_KEY][id][_QUANTITY_KEY]


func _on_xp_collected(number: float):
	total_xp += number
