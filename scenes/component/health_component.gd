extends Node
class_name HealthComponent


signal died
signal health_changed

@export var max_health: float = 10

var current

func _ready():
	current = max_health


func damage(amount: float):
	current = max(current - amount, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()


func get_health_percent():
	if max_health <= 0:
		return 0
		
	return min(current / max_health, 1)


func check_death():
	if current > 0:
		return
		
	died.emit()
	owner.queue_free()
