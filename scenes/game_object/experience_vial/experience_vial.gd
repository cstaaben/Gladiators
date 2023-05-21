extends Node2D


func _ready():
	$Area2D.area_entered.connect(_on_area_entered)


func _on_area_entered(_area: Area2D):
	GameEvents.emit_xp_vial_collected(1)
	queue_free()
