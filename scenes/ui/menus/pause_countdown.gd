extends CanvasLayer

signal finished

@onready var countdown_label: Label = %CountdownLabel
@onready var countdown_timer: Timer = %CountdownTimer

var starting_count: int = 3
var current: int = starting_count

func _ready():
	countdown_timer.timeout.connect(_on_timeout)
	countdown_label.text = "%d" % starting_count
	start_timer()
	
	
func start_timer():
	countdown_timer.start(1)
	animate_label()
	

func _on_timeout():
	decrement_current()
	if current <= 0:
		finished.emit()
		return
		
	countdown_label.text = "%d" % current
	start_timer()


func decrement_current():
	if current == 0:
		current = starting_count
		return
		
	current -= 1


func animate_label():
	var tween = create_tween()
	tween.tween_property(countdown_label, "scale", Vector2.ZERO, 0)
	tween.tween_property(countdown_label, "scale", Vector2(2.0, 2.0), 0.5).\
		set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(countdown_label, "scale", Vector2.ZERO, 0.5).\
		set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		
	tween.play()
	await tween.finished
