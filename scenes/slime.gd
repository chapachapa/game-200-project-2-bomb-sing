extends RigidBody2D

func _physics_process(delta):
	pass


func on_beat(beat):
	pass


func on_bar(bar):
	apply_impulse(Vector2.UP * 500)


func on_damage():
	queue_free()


func on_shocked(start_position, velocity):
	# find direction from start position and end position
	var direction = (start_position - get_global_position()).normalized()
	
	apply_impulse(-direction * velocity)
