extends PanelContainer
class_name MetaUpgradeCard

signal selected

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel

var _upgrade: MetaUpgrade

var disabled: bool = false

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	purchase_button.pressed.connect(_on_purchase_button_pressed)
	
	
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


func set_meta_upgrade(upgrade: MetaUpgrade):
	self._upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()


func update_progress():
	var total_xp = MetaProgression.meta_data[MetaProgression.TOTAL_XP_KEY]
	var percent = total_xp / _upgrade.xp_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(total_xp) + "/" + str(_upgrade.xp_cost)
	
	
func select_card():
	disabled = true
	$SelectedAudioPlayer.play_random()
	var tween = create_tween()
	tween.tween_property(self, "position", position + (Vector2.DOWN * 10), 0.1)
	tween.tween_property(self, "position", position + (Vector2.UP * -25), 0.2)
	tween.tween_property(self, "position", position, 0.1)
	
	await tween.finished
	selected.emit()
	
	
func _on_mouse_entered():
	if disabled:
		return
		
	$HoverAudioPlayer.play_random()
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * 1.15, 0.1)
	
	
func _on_mouse_exited():
	if disabled:
		return
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)


func _on_purchase_button_pressed():
	if _upgrade == null:
		return

	MetaProgression.add_meta_upgrade(_upgrade)
	print(MetaProgression.meta_data[MetaProgression.TOTAL_XP_KEY])
	MetaProgression.meta_data[MetaProgression.TOTAL_XP_KEY] -= _upgrade.xp_cost
	print(MetaProgression.meta_data[MetaProgression.TOTAL_XP_KEY])
	MetaProgression.save_data()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	select_card()
