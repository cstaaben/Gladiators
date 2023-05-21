extends CanvasLayer

@export var experience_manager: ExperienceManager
@onready var progress_bar: ProgressBar = %ProgressBar


func _ready():
	progress_bar.value = 0
	experience_manager.xp_updated.connect(_on_xp_updated)
	

func _on_xp_updated(current_xp: float, target_xp: float):
	if target_xp == 0:
		return
		
	var percent = current_xp / target_xp
	progress_bar.value = percent
