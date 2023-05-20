extends Node

var current_xp = 0

func _ready():
	GameEvents.xp_vial_collected.connect(on_xp_vial_collected)


func on_xp_vial_collected(number: float):
	inc_experience(number)


func inc_experience(xp: float):
	current_xp += xp
	print(current_xp)
