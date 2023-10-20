extends Node

# Mic
const MIN_DB: int = 80
var volume = 0.0
var energy = 0.0
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance


func _ready():
	spectrum_analyzer = AudioServer.get_bus_effect_instance(3, 0)


func _process(delta):
	# MIC Processing
	volume = db_to_linear(AudioServer.get_bus_peak_volume_left_db(3, 0))
	
	# find the pitch
	var magnitude = spectrum_analyzer.get_magnitude_for_frequency_range(0, 200).length()
	
	# boost the signal and normalize it
	energy = clamp((MIN_DB + linear_to_db(magnitude))/MIN_DB, 0, 1)
	print(energy)
