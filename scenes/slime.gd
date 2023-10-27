extends RigidBody2D
var isDown = false

var explosion_particle = preload("res://scenes/particles/slime_explosion.tscn")


func _physics_process(delta):
	pass


func on_beat(beat):
	pass


func on_bar(bar):
	##apply_impulse(Vector2.UP * 500)
	if(!isDown):
		$AnimationPlayer.play("squash_down")
		isDown = true
	elif(isDown):
		$AnimationPlayer.play("squash_up")
		isDown = false
	


func on_damage():
	var e = explosion_particle.instantiate()
	get_parent().add_child(e)
	e.set_global_position(get_global_position())
	
	queue_free()


func on_shocked(start_position, velocity):
	# find direction from start position and end position
	var direction = (start_position - get_global_position()).normalized()
	
	apply_impulse(-direction * velocity)
