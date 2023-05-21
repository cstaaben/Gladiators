extends PanelContainer
class_name AbilityUpgradeCard

signal selected

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel  


func _ready():
	gui_input.connect(_on_gui_input)


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	
	
func _on_gui_input(event: InputEvent):
	if !event.is_action_pressed("left_click"):
		return
		
	selected.emit()
