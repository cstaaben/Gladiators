extends Node
class_name HealthComponent


signal died
signal health_changed
signal damage_taken

@export var max_health: float = 10

var current

func _ready():
	current = max_health


func damage(amount: float):
	current = clamp(current - amount, 0, max_health)
	health_changed.emit()
	if amount > 0:
		damage_taken.emit()
	Callable(check_death).call_deferred()


func heal(amount: float):
	damage(-1 * amount)


func get_health_percent():
	if max_health <= 0:
		return 0
		
	return min(current / max_health, 1)


func check_death():
	if current > 0:
		return
		
	died.emit()
	owner.queue_free()
