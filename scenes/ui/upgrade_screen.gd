extends CanvasLayer
class_name UpgradeScreen

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer


func _ready():
	toggle_pause()


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.selected.connect(_on_upgrade_selected.bind(upgrade))
		
		
func _on_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	toggle_pause()
	queue_free()


func toggle_pause():
	get_tree().paused = !get_tree().paused
