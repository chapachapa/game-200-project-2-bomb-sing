extends StaticBody2D


func on_damage():
	queue_free()


func on_shocked(start_position, velocity):
	# find direction from start position and end position
	var direction = (start_position - get_global_position()).normalized()
	
	#apply_impulse(-direction * velocity)
	queue_free()
