extends Node


signal exp_vial_collected(number: float)

func emit_exp_vial_collected(number: float):
	exp_vial_collected.emit(number)
