extends Node2D

var press_time
var current_pitch = -1

var pitches = ["Pitch 1", "Pitch 2", "Pitch 3", "Pitch 4", "Pitch 5"]
var sing_audio = []

# Called when the node enters the scene tree for the first time.
func _ready():
	sing_audio = [$Singing1, $Singing2, $Singing3, $Singing4, $Singing5]
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("sing"):
		press_time = Time.get_ticks_msec()
	if Input.is_action_pressed("sing"):
		var y_size = $PitchPointer.Y_MAX - $PitchPointer.Y_MIN
		var pitch_index = floor(pitches.size() * ($PitchPointer.position.y - $PitchPointer.Y_MIN) / y_size)
		
		##### TEMPORARY FIX - math has to be tweaked - bugsout on the max value giving it an index 5
		if pitch_index == 5:
			pitch_index = 4
		##### TEMPORARY I SAID
			
		var current_time = Time.get_ticks_msec()
		$HUD.update_debug_label(pitches[pitch_index] +", "+ str(current_time-press_time))
		
		# if pitch is different, need to reset music and play a different one
		if current_pitch != pitch_index:
			for a in sing_audio.size():
				if pitch_index == a:
					sing_audio[a].play()
				else:
					sing_audio[a].stop()
			current_pitch = pitch_index
	if Input.is_action_just_released("sing"):
		if current_pitch != -1:
			sing_audio[current_pitch].stop()
		current_pitch = -1

#func _input(event):
	# Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
