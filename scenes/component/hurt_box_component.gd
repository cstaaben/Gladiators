extends Area2D
class_name HurtboxComponent


signal hit


@export var health: HealthComponent

var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")


func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if not area is HitboxComponent or health == null:
		return

	var hitbox = area as HitboxComponent
	health.damage(hitbox.damage)
	
	var floating_text = floating_text_scene.instantiate() as Node2D
	var foreground = get_tree().get_first_node_in_group("foreground_layer")
	if foreground == null:
		return
		
	foreground.add_child(floating_text)
	floating_text.global_position = global_position
	var format_string = "%0.1f"
	if round(hitbox.damage) == hitbox.damage:
		format_string = "%d"
	floating_text.start((format_string % hitbox.damage))
	
	hit.emit()
