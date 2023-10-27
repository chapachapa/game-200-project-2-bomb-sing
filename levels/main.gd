extends Node

# Custom Beat Syncing System
const BPM = 120
const BARS = 16
const COMPENSATE_FRAMES = 2
const COMPENSATE_HZ = 60.0
var previous_beat = 0

# Used by system clock.
var time_begin
var time_delay

# Ref
var bomb = preload("res://scenes/bomb.tscn")
var camera_following = false
var explosionSfx = preload("res://scenes/explosion_sfx.tscn")

# show/hide UI
var showVisualizer = false;

func _ready():
	Global.main_scene = self
	
	# Initialize the syncing
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	
	Global.checkpoint = $Node2D/StartPos.get_global_position()
	launch_bomb()
	camera_following = true

func _input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _physics_process(delta):
	if camera_following:
		# find the centroid position from all bombs
		var centroid = Vector2()
		for i in Global.bombs:
			centroid += i.get_global_position()
			centroid /= Global.bombs.size()

		$Node2D/Camera2D.set_global_position(centroid)

func _process(_delta):
	if not $Beat.is_playing():
		return
	
	var time = 0.0
	# Obtain from ticks.
	time = (Time.get_ticks_usec() - time_begin) / 1000000.0
	# Compensate.
	time -= time_delay
	
	var beat = int(time * BPM / 60.0)
	
	if beat != previous_beat:
		on_beat(beat % BARS + 1)

		if beat % 4 == 0:
			on_bar(beat % 4)
		
	previous_beat = beat
	
	# update UI
	$CanvasLayer/Control/Volume.set_value(Global.volume)
	$CanvasLayer/Control/Pitch.set_value(Global.energy)
	$CanvasLayer/SpectrumVisualizer.spect_array = Global.magnitueds_by_range
	#print(Global.magnitude)
	
	if Input.is_action_just_pressed("calibration"):
		$CanvasLayer/SpectrumVisualizer.set_visible(!$CanvasLayer/SpectrumVisualizer.visible)
		
	if Global.volume > Global.volumeThreshold:
		var targetAngle = -180*(Global.energy-0.5)
		# $CanvasLayer/Control/PitchDirectionIndicator.rotation_degrees = targetAngle
		var tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/Control/PitchDirectionIndicator, "rotation_degrees", targetAngle , 0.2)
		tween.parallel().tween_property($CanvasLayer/Control/PitchDirectionIndicator, "scale", lerp(Vector2(0.3, 0.3), Vector2(0.75, 0.75), Global.volume), 0.2)
	else:
		# $CanvasLayer/Control/PitchDirectionIndicator.rotation_degrees = 0
		
		var tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/Control/PitchDirectionIndicator, "rotation_degrees", 0 , 0.2)
		tween.parallel().tween_property($CanvasLayer/Control/PitchDirectionIndicator, "scale", lerp(Vector2(0.3, 0.3), Vector2(0.75, 0.75), Global.volume), 0.2)
		
func on_beat(beat):
	#print("beat %d" % beat)
	
	for i in get_tree().get_nodes_in_group("beat"):
		i.on_beat(beat)
	
	# spawn a new bomb every 4 bar
	#if ((beat - 1) % 4 == 0):
	#	launch_bomb()


func on_bar(bar):
	#print("bar %d" % bar)
	
	for i in get_tree().get_nodes_in_group("beat"):
		if i.has_method("on_bar"):
			i.on_bar(bar)


func launch_bomb():
	var b = bomb.instantiate()
	$Node2D.add_child(b)
	b.set_global_position(Global.checkpoint)


func bomb_destroyed():
	print(Global.bombs.size())
	if Global.bombs.size() <= 0:
		camera_following = false
		
		await get_tree().create_timer(1.0).timeout
		
		launch_bomb()
		camera_following = true
		
