extends Node


signal died

@export var max_health: float = 10

var current

func _ready():
	current = max_health


func damage(amount: float):
	current = max(current - amount, 0)
	if current > 0:
		return
		
	died.emit()
	owner.queue_free()
