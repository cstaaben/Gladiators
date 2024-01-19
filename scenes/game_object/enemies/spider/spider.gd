extends CharacterBody2D


@onready var visuals: Node2D = $Visuals
@onready var walk_velocity_component: VelocityComponent = %WalkVelocityComponent
@onready var jump_velocity_component: VelocityComponent = %JumpVelocityComponent
@onready var jump_cooldown_timer: Timer = %JumpCooldownTimer

@export var jumping: bool = false

const JUMP_DISTANCE: int = 80


func _ready():
	$HurtboxComponent.hit.connect(_on_hit)
	jump_cooldown_timer.timeout.connect(_on_jump_cooldown_timeout)
	
	
func _on_jump_cooldown_timeout():
	pass
	
	
func _on_hit():
	$RandomAudioPlayer2DComponent.play_random()
	
	
func _physics_process(_delta):
	var player_distance: float = jump_velocity_component.distance_to_player()
	jump_velocity_component.accelerate_to_player()
	# cooldown hasn't finished or player is too far away
	if !jump_cooldown_timer.is_stopped() || player_distance > JUMP_DISTANCE:
		return
		
	# TODO: use a tween for jump animation
	
	# within range of player, start jump attack
	if !jumping:
		$AnimationPlayer.play("jump")
		await $AnimationPlayer.animation_finished
		jump_cooldown_timer.start()


# TODO: extend animation time or shorten radius; spider glides towards player
# after landing
# TODO: prevent spider from turning in "mid-air" towards the player; need to
# "jump" in a straight line
func _process(_delta):
	if jumping:
		jump_velocity_component.move(self)
		return
		
	walk_velocity_component.accelerate_to_player()
	walk_velocity_component.move(self)
