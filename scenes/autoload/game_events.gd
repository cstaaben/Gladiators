extends Node


signal xp_vial_collected(number: float)

func emit_xp_vial_collected(number: float):
	xp_vial_collected.emit(number)
