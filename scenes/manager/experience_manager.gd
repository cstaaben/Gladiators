extends Node
class_name ExperienceManager

signal xp_updated(current_xp: float, target_xp: float)
signal level_up(new_level: int)

const TARGET_XP_GROWTH = 5

var current_xp = 0
var current_level = 1
var target_experience = 5

func _ready():
	GameEvents.xp_vial_collected.connect(_on_xp_vial_collected)


func _on_xp_vial_collected(number: float):
	inc_experience(number)


func inc_experience(xp: float):
	current_xp = min(current_xp + xp, target_experience)
	xp_updated.emit(current_xp, target_experience)
	if current_xp != target_experience:
		return
		
	current_level += 1
	target_experience += TARGET_XP_GROWTH
	current_xp = 0
	xp_updated.emit(current_xp, target_experience)
	level_up.emit(current_level)
