extends CharacterBody2D


@onready var visuals: Node2D = $Visuals
@onready var walk_velocity_component: VelocityComponent = %WalkVelocityComponent
@onready var jump_velocity_component: VelocityComponent = %JumpVelocityComponent
@onready var jump_cooldown_timer: Timer = %JumpCooldownTimer

var jump_distance: int = 100

func _ready():
	$HurtboxComponent.hit.connect(_on_hit)
	
	
func _on_hit():
	$RandomAudioPlayer2DComponent.play_random()


# TODO: why isn't the "jump" moving the spider any further than the walking?
func _process(_delta):
	var player_distance = walk_velocity_component.distance_to_player()
	# always align direction to player
	walk_velocity_component.accelerate_to_player()
	jump_velocity_component.accelerate_to_player()

	# if spider is too far away to jump attack or its not able to jump yet, walk towards player
	if player_distance > self.jump_distance || !jump_cooldown_timer.is_stopped():
		walk_velocity_component.move(self)
		return

	# spider is within range, start jump attack
	$AnimationPlayer.play("jump")
	jump_velocity_component.move(self)
	jump_cooldown_timer.start()
