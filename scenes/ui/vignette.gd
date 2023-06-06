extends CanvasLayer


func _ready():
	GameEvents.player_damaged.connect(_on_player_damaged)
	
	
func _on_player_damaged():
	$AnimationPlayer.play("hit")
