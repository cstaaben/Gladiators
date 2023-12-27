extends Node


signal xp_vial_collected(number: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damaged()
signal time_ticked(timestamp: int)

@onready var timer: Timer = $Timer


func _ready():
	timer.timeout.connect(_on_timer_timeout)


func emit_xp_vial_collected(number: float):
	xp_vial_collected.emit(number)
	
	
func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)
	

func emit_player_damaged():
	player_damaged.emit()


func _on_timer_timeout():
	time_ticked.emit(int(Time.get_unix_time_from_system()))
	timer.start()
