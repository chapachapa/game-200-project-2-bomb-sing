extends Node2D

func _physics_process(delta):
	move_local_x(5)


func on_beat(beat):
	pass


func on_bar(bar):
	pass


func _on_body_entered(body):
	if "Slime" in body.name:
		body.queue_free()
	
	queue_free()
