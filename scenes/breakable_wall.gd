extends StaticBody2D

var explosion_particle = preload("res://scenes/particles/box_explosion.tscn")


func on_damage():
	var e = explosion_particle.instantiate()
	get_parent().add_child(e)
	e.set_global_position(get_global_position())
	
	queue_free()


func on_shocked(start_position, velocity):
	var e = explosion_particle.instantiate()
	get_parent().add_child(e)
	e.set_global_position(get_global_position())
	
	queue_free()
