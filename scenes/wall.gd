extends StaticBody2D

@export var moving = false
@export var move_beat = 2

var index = 1
var positions = []


func _ready():
	for i in range(1, 3):
		positions.append(get_node("Location%d" % i).get_global_position())
		print(get_node("Location%d" % i).get_position())


func _physics_process(delta):
	pass


func on_beat(beat):
	if moving and beat % move_beat == 0:
		$Sprite.set_scale(Vector2(1.1, 1.1))
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property($Sprite, "scale", Vector2(1, 1), 0.2)
		
		tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(self, "position", positions[index], 0.2)
		index = wrapi(index + 1, 0, positions.size())


func on_bar(bar):
	pass
