extends Node
class_name VelocityComponent

@export var max_speed: int = 40
@export var acceleration: float = 5

var velocity = Vector2.ZERO

func move(body: CharacterBody2D):
	body.velocity = velocity
	body.move_and_slide()
	velocity = body.velocity
	
	
func accelerate_in_direction(direction: Vector2):
	var target_velocity = direction * max_speed
	velocity = velocity.lerp(target_velocity, 1 - exp(-acceleration * get_process_delta_time()))
	
	
func accelerate_to_player():
	var direction = direction_to_player()
	accelerate_in_direction(direction)
	
	
func decelerate():
	accelerate_in_direction(Vector2.ZERO)


## Returns a normalized Vector2 indicating the direction to the player. It returns [Vector2.ZERO] 
## if either the owner or the player is null.
func direction_to_player() -> Vector2:	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	
	var owner_node = owner as Node2D
	if owner_node == null:
		return Vector2.ZERO


	return (player.global_position - owner_node.global_position).normalized()


## Returns a the distance to the player. It returns [Vector2.ZERO] if either the
## owner or the player is null.
func distance_to_player() -> float:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return 0
	
	var owner_node = owner as Node2D
	if owner_node == null:
		return 0
	
	return owner_node.global_position.distance_to(player.global_position)