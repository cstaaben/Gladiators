extends CanvasLayer

signal transitioned_halfway

var _skip_emit: bool = false

func transition():
	$AnimationPlayer.play("default")
	await transitioned_halfway

	_skip_emit = true
	$AnimationPlayer.play_backwards("default")


func transition_to_scene(scene_path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(scene_path)


func emit_transitioned_halfway():
	if _skip_emit:
		_skip_emit = false
		return
	transitioned_halfway.emit()
