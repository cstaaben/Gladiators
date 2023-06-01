extends AudioStreamPlayer


@export var streams: Array[AudioStream]
@export var min_pitch: float = 0.9
@export var max_pitch: float = 1.1
@export var randomize_pitch: bool = true


func play_random():
	if streams == null || streams.size() == 0:
		return
		
	var pitch: float = 1.0
	if randomize_pitch:
		pitch = randf_range(min_pitch, max_pitch)
		
	pitch_scale = pitch
	stream = streams.pick_random()
	play()
