extends CharacterBody2D


const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

@onready var damage_timer: Timer = $DamageTimer
@onready var health: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $HealthBar
@onready var abilities: Node = $Abilities
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node2D = $Visuals

var number_colliding_bodies: int

func _ready():
	$CollisionArea.body_entered.connect(_on_body_entered)
	$CollisionArea.body_exited.connect(_on_body_exited)
	damage_timer.timeout.connect(_on_damage_timer_timeout)
	health.health_changed.connect(_on_health_changed)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)
	update_health_display()
	

func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	move_and_slide()
	
	if movement_vector.x != 0 || movement_vector.y != 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
		
	var move_sign = sign(movement_vector.x)
	if move_sign == 0:
		visuals.scale = Vector2.ONE
	else:
		visuals.scale = Vector2(move_sign, 1)


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	return Vector2(x_movement, y_movement)


func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_timer.is_stopped():
		return
		
	health.damage(1)
	damage_timer.start()
	
	
func update_health_display():
	health_bar.value = health.get_health_percent()


func _on_body_entered(_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func _on_body_exited(_body: Node2D):
	number_colliding_bodies -= 1
	
	
func _on_damage_timer_timeout():
	check_deal_damage()
	
	
func _on_health_changed():
	update_health_display()
	
	
func _on_ability_upgrade_added(upgrade: AbilityUpgrade, _current_upgrades: Dictionary):
	if not upgrade is Ability:
		return
		
	abilities.add_child(upgrade.ability_controller_scene.instantiate())
