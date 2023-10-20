extends Node2D

@export var speed = 5

func _ready():
	var devices = AudioServer.get_input_device_list()
	print(devices)


func _physics_process(delta):
	move_local_x(speed)
	
	# move the bomb by pitch and volume
	move_local_y((Global.energy - 0.5) * 20 * Global.volume)


func on_beat(beat):
	$Sprite.set_scale(Vector2(1.2, 1.2))
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($Sprite, "scale", Vector2(1, 1), 0.2)


func on_bar(bar):
	pass


func _on_body_entered(body):
	if "Slime" in body.name:
		body.queue_free()
	
	queue_free()
