extends RigidBody2D

func _physics_process(delta):
	pass


func on_beat(beat):
	pass


func on_bar(bar):
	apply_impulse(Vector2.UP * 500)
