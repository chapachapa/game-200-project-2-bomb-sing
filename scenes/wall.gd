extends StaticBody2D

@export var moving = false
@export var move_beat = 0
var targets = []
var index

func _physics_process(delta):
	pass


func on_beat(beat):
	$Sprite.set_scale(Vector2(1.1, 1.1))
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($Sprite, "scale", Vector2(1, 1), 0.2)
	
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "position", get_position() + Vector2(0, 20), 0.2)


func on_bar(bar):
	pass
