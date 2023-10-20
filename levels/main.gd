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


func _ready():
	# Initialize the syncing
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	
	launch_bomb()


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


func on_beat(beat):
	print("beat %d" % beat)
	
	for i in get_tree().get_nodes_in_group("beat"):
		i.on_beat(beat)
	
	# spawn a new bomb every 4 bar
	if ((beat - 1) % 8 == 0):
		launch_bomb()


func on_bar(bar):
	print("bar %d" % bar)
	
	for i in get_tree().get_nodes_in_group("beat"):
		i.on_bar(bar)


func launch_bomb():
	var b = bomb.instantiate()
	$Node2D.add_child(b)
	b.set_global_position($Node2D/StartPos.get_global_position())
