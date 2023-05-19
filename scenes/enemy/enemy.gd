extends CharacterBody2D


const MAX_SPEED = 75

func _ready():
	$Area2D.area_entered.connect(on_area_entered)


func _process(_delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO


func on_area_entered(_area: Area2D):
	queue_free()
