extends PanelContainer
class_name AbilityUpgradeCard

signal selected

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel

var disabled: bool = false

func _ready():
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	
func play_in(delay: float = 0.0, is_left: bool = false):
	modulate = Color.TRANSPARENT
	var direction_vector: Vector2 = Vector2.RIGHT
	if is_left:
		direction_vector = Vector2.LEFT
	await get_tree().create_timer(delay).timeout
	var tween = create_tween()
	tween.tween_property(self, "position", position, 0.4)\
		.from(direction_vector * 500)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self, "modulate", Color.WHITE, 0.4)
	
	
func play_discard():
	$SelectedPlayer.play("discard")


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	
	
func _on_gui_input(event: InputEvent):
	if !event.is_action_pressed("left_click") || disabled:
		return
	
	select_card()
	
	
func select_card():
	disabled = true
	var tween = create_tween()
	tween.tween_property(self, "position", position + (Vector2.DOWN * 10), 0.1)
	tween.tween_property(self, "position", position + (Vector2.UP * -25), 0.2)
	tween.tween_property(self, "position", position, 0.1)
	
	for card in get_tree().get_nodes_in_group("upgrade_card"):
		if card == self:
			continue
		card.play_discard()
	
	await tween.finished
	selected.emit()
	
	
func _on_mouse_entered():
	if disabled:
		return
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * 1.15, 0.1)
	
	
func _on_mouse_exited():
	if disabled:
		return
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)
	
