extends Node2D


func _ready():
	$CPUParticles2D.set_emitting(true)

func _on_timer_timeout():
	queue_free()
