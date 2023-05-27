extends CanvasLayer
class_name UpgradeScreen

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer


func _ready():
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for i in upgrades.size():
		var upgrade = upgrades[i]
		var card_instance = upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.play_in(i * 0.15, i % 2 == 0)
		card_instance.selected.connect(_on_upgrade_selected.bind(upgrade))
		
		
func _on_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()
