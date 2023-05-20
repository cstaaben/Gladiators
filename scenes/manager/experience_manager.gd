extends Node

var current_exp = 0

func _ready():
	GameEvents.exp_vial_collected.connect(on_exp_vial_collected)


func on_exp_vial_collected(number: float):
	inc_experience(number)


func inc_experience(exp: float):
	current_exp += exp
	print(current_exp)
