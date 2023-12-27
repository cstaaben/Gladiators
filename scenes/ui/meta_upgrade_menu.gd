extends CanvasLayer

signal meta_selected

@export var ui_testing_mode: bool = false
@export var upgrades: Array[MetaUpgrade] = []

@onready var grid_container: GridContainer = %GridContainer
@onready var cancel_button: Button = %CancelButton

var _meta_upgrade_card_scene = preload("res://scenes/ui/meta_upgrade_card.tscn")

func _ready():
	cancel_button.pressed.connect(_on_cancel_pressed)
	if ui_testing_mode:
		return

	for child in %GridContainer.get_children():
		child.queue_free()

	for upgrade in upgrades:
		var meta_upgrade_card_instance = _meta_upgrade_card_scene.instantiate()
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)
		meta_upgrade_card_instance.selected.connect(_on_meta_card_selected)


func _on_meta_card_selected():
	meta_selected.emit()


func _on_cancel_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/main_menu.tscn")
