extends CanvasLayer

@onready var camera = %MapCamera as MapCamera
@onready var map_manager = %MapManager as MapManager
@onready var count_spin_box = %CountSpinBox as SpinBox
@onready var loops_spin_box = %LoopsSpinBox as SpinBox
@onready var birth_spin_box = %BirthSpinBox as SpinBox
@onready var death_spin_box = %DeathSpinBox as SpinBox
@onready var x_spin_box = %XSpinBox as SpinBox
@onready var y_spin_box = %YSpinBox as SpinBox
@onready var submit_button = %SubmitButton as Button
@onready var clear_button = %ClearButton as Button
@onready var play_button = %PlayButton as Button
@onready var log_button = %LogButton as Button
@onready var back_button = %BackButton as SoundButton
@onready var zoom_in_button = %ZoomInButton as Button
@onready var zoom_out_button = %ZoomOutButton as Button


var counter: int = 1

func _ready():
	# signal connections
	submit_button.pressed.connect(_on_submit_pressed)
	clear_button.pressed.connect(_on_clear_pressed)
	play_button.pressed.connect(_on_play_pressed)
	log_button.pressed.connect(_on_log_pressed)
	back_button.pressed.connect(_on_back_pressed)
	zoom_in_button.pressed.connect(_on_zoom_in_pressed)
	zoom_out_button.pressed.connect(_on_zoom_out_pressed)
	
	# spin box defaults
	count_spin_box.set_value_no_signal(map_manager.get_walker_count())
	loops_spin_box.set_value_no_signal(map_manager.get_walker_loops())
	birth_spin_box.set_value_no_signal(map_manager.get_walker_birth_chance())
	death_spin_box.set_value_no_signal(map_manager.get_walker_death_chance())
	x_spin_box.set_value_no_signal(map_manager.get_map_size().x)
	y_spin_box.set_value_no_signal(map_manager.get_map_size().y)


func _on_back_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/menus/main_menu.tscn")


func _on_zoom_in_pressed():
	camera.zoom_in() 


func _on_zoom_out_pressed():
	camera.zoom_out()
	
	
func _on_submit_pressed():
	var count: int = count_spin_box.value
	var loops: int = loops_spin_box.value
	var birth_chance: float = birth_spin_box.value
	var death_chance: float = death_spin_box.value
	var map_size = Vector2(x_spin_box.value, y_spin_box.value)
	
	map_manager.set_map_size(map_size)
	map_manager.set_walker_count(count)
	map_manager.set_walker_loops(loops)
	map_manager.set_walker_birth_chance(birth_chance)
	map_manager.set_walker_death_chance(death_chance)
	map_manager.reset_map()
	
	# map_manager.create_map()
	
	
func _on_clear_pressed():
	count_spin_box.set_value_no_signal(10)
	loops_spin_box.set_value_no_signal(100)
	birth_spin_box.set_value_no_signal(0.05)
	death_spin_box.set_value_no_signal(0.01)
	x_spin_box.set_value_no_signal(500)
	y_spin_box.set_value_no_signal(500)
	
	
func _on_play_pressed():
	var paused: bool = get_tree().paused
	get_tree().paused = !paused
	
	if paused:
		play_button.text = "Play"
	else:
		play_button.text = "Pause"
	
	
func _on_log_pressed():
	var count: int = count_spin_box.value
	var loops: int = loops_spin_box.value
	var birth_chance: float = birth_spin_box.value
	var death_chance: float = death_spin_box.value
	var map_size = Vector2(x_spin_box.value, y_spin_box.value)
	
	print_debug("Saved values #%d:\n\tWalker count: %d\n\tWalker loops: %d\n\t" + \
		"Walker birth chance: %.3f\n\tWalker death chance: %.3f\n\t" + \
		"Map size: %s\n" % [counter, count, loops, birth_chance, death_chance, map_size])
	
	counter += 1
