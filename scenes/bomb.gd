extends Node2D

signal bomb_destroyed

@export var speed = 5

var explosion_particle = preload("res://scenes/particles/explosion_particle.tscn")
var explosionSfx = preload("res://scenes/explosion_sfx.tscn")

func _ready():
	var devices = AudioServer.get_input_device_list()
	#print(devices)
	
	Global.bombs.append(self)

func _physics_process(delta):
	move_local_x(speed)
	
	# move the bomb by pitch and volume
	if(Global.volume > Global.volumeThreshold):
		move_local_y((Global.energy - 0.5) * -1 * 20)


func on_beat(beat):
	$Sprite.set_scale(Vector2(3, 3) * 1.2)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($Sprite, "scale", Vector2(3, 3), 0.2)


func on_bar(bar):
	pass


func _input(event):
	if Input.is_action_just_pressed("explode"):
		on_damage()


func _on_body_entered(body):
	if body.has_method("on_damage"):
		body.on_damage()
	
	on_damage()


func on_damage():
	var e = explosion_particle.instantiate()
	get_parent().add_child(e)
	e.set_global_position(get_global_position())
	
	
	# add soundeffect
	get_parent().add_child(explosionSfx.instantiate())
	
	# effect things around the object
	for i in $ExtraRange.get_overlapping_bodies():
		if i.has_method("on_shocked"):
			i.on_shocked(get_global_position(), 1000)
	
	Global.main_scene.bomb_destroyed()
	Global.bombs.erase(self)
	emit_signal("bomb_destroyed")
	
	queue_free()
