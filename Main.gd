extends Node2D

var press_time

var pitches = ["Pitch 1", "Pitch 2", "Pitch 3", "Pitch 4", "Pitch 5"];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("sing"):
		press_time = Time.get_ticks_msec()
	if Input.is_action_pressed("sing"):
		var y_size = $PitchPointer.Y_MAX - $PitchPointer.Y_MIN
		var pitch_index = floor(pitches.size() * ($PitchPointer.position.y - $PitchPointer.Y_MIN) / y_size)
		var current_time = Time.get_ticks_msec()
		$HUD.update_debug_label(pitches[pitch_index] +", "+ str(current_time-press_time))


#func _input(event):
	# Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
