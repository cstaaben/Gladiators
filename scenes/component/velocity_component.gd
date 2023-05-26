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
	var owner_node = owner as Node2D
	if owner_node == null:
		return
		
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var direction = (player.global_position - owner_node.global_position).normalized()
	accelerate_in_direction(direction)
	
	
func decelerate():
	accelerate_in_direction(Vector2.ZERO)
