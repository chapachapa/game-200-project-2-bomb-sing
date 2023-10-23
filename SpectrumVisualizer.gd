extends Control


var bar_width = 5
var bar_start_position = Vector2(0, 0)
var bar_max_magnitude = 400
var spect_array = []
var progress_bar_array = []
var mag_boost = 10000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spect_array.size() != progress_bar_array.size():
		progress_bar_array.resize(spect_array.size())
	for i in spect_array.size():
		if !progress_bar_array[i]: 
			progress_bar_array[i] = ProgressBar.new()
		progress_bar_array[i].set_show_percentage(false)
		progress_bar_array[i].set_fill_mode(3)
		progress_bar_array[i].max_value = bar_max_magnitude
		progress_bar_array[i].set_size(Vector2(bar_width, 300))
		progress_bar_array[i].set_position(bar_start_position + Vector2(bar_width * i, 0))
		
		progress_bar_array[i].set_value(spect_array[i] * mag_boost)
		add_child(progress_bar_array[i])
