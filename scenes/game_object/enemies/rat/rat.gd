extends CharacterBody2D


@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent


func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign == 0:
		return
		
	visuals.scale = Vector2(-move_sign, 1)
