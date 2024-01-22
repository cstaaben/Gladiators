extends CanvasLayer

signal back_pressed

@onready var window_button: Button = %WindowButton
@onready var sfx_slider: HSlider = %SfxSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var back_button: Button = %BackButton


func _ready():
	window_button.pressed.connect(_on_window_button_pressed)
	sfx_slider.value_changed.connect(_on_audio_slider_changed.bind("sfx"))
	music_slider.value_changed.connect(_on_audio_slider_changed.bind("music"))
	back_button.pressed.connect(_on_back_pressed)

	update_display()


func update_display():
	window_button.text = "Windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Fullscreen"
	
	sfx_slider.value = _get_bus_volume_percent("sfx")
	music_slider.value = _get_bus_volume_percent("music")


func _get_bus_volume_percent(bus_name: String):
	var bus_idx = AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_idx)
	return db_to_linear(volume_db)


func _set_bus_volume_percent(bus_name: String, percent: float):
	var bus_idx = AudioServer.get_bus_index(bus_name)
	var volume_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_idx, volume_db)
	


func _on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	update_display()


func _on_audio_slider_changed(value: float, bus_name: String):
	_set_bus_volume_percent(bus_name, value)


func _on_back_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	back_pressed.emit()
