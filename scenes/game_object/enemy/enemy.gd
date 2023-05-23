extends CharacterBody2D


const MAX_SPEED = 40

@onready var health: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals


func _process(_delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	var move_sign = sign(velocity.x)
	if move_sign == 0:
		return
		
	visuals.scale = Vector2(-move_sign, 1)


func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
