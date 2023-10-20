extends Node

# Mic
const MIN_DB: int = 80
var volume = 0.0
var energy = 0.0
var magnitude = 0.0
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance
const MAX_FREQ = 5000;
const MIN_FREQ = 0;
const FREQ_INTERVAL = 10;
var magnitueds_by_range = [];


func _ready():
	spectrum_analyzer = AudioServer.get_bus_effect_instance(3, 0)


func _process(delta):
	# MIC Processing
	volume = db_to_linear(AudioServer.get_bus_peak_volume_left_db(3, 0))
	
	# find the pitch
	# magnitude = linear_to_db(spectrum_analyzer.get_magnitude_for_frequency_range(0, 200).length())
	var max = 0;
	var mIndex = -1;
	for n in floor((MAX_FREQ - MIN_FREQ) / FREQ_INTERVAL):
		var freq = MIN_FREQ + (FREQ_INTERVAL * n);
		var intervalMagnitudeVector = spectrum_analyzer.get_magnitude_for_frequency_range(
			freq,
			freq+FREQ_INTERVAL, 
			AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE);
		var intervalMagnitudeAverage = intervalMagnitudeVector.x + intervalMagnitudeVector.y / 2;
		if intervalMagnitudeAverage > max:
			mIndex = n;
			max = intervalMagnitudeAverage;
	print("::::::::::::::::::::: highest in range is .... ", mIndex, " ... ", mIndex / 30.0);
	mIndex;
		
	
	# boost the signal and normalize it
	#energy = clamp((MIN_DB + (magnitude))/MIN_DB, 0, 1)
	energy = mIndex / 30.0;
	print(energy)
