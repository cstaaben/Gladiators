extends Node2D

@onready var sprite = $Sprite2D

func _ready():
	$Area2D.area_entered.connect(_on_area_entered)
	
	
func player_pickup(percent: float, start_position: Vector2):
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	global_position = start_position.lerp(player.global_position, percent)
	var direction_from_start = player.global_position - start_position
	var target_rotation = direction_from_start.angle() + deg_to_rad(90)
	rotation = lerp_angle(rotation, target_rotation, 1 - exp(-3 * get_process_delta_time()))
	
	
func collect():
	GameEvents.emit_xp_vial_collected(1)
	queue_free()


func _on_area_entered(_area: Area2D):
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(player_pickup.bind(global_position), 0.0, 1.0, 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUINT)
	tween.set_speed_scale(2.0)
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.15).set_delay(0.35)
	tween.chain()
	tween.tween_callback(collect)
	
	
	$RandomAudioPlayer2DComponent.play_random()
	
