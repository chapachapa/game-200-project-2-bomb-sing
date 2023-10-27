extends Area2D

enum TOUCH {CHECKPOINT, DOUBLE}
@export var type = TOUCH.CHECKPOINT

var bomb = preload("res://scenes/bomb.tscn")
var checkpoint_particle = preload("res://scenes/particles/checkpoint_explosion.tscn")
var double_particle = preload("res://scenes/particles/double_explosion.tscn")


func _ready():
	match type:
		TOUCH.CHECKPOINT:
			$Checkpoint.show()
		TOUCH.DOUBLE:
			$Double.show()


func _on_body_entered(body):
	pass


func _on_area_entered(area):
	if area in get_tree().get_nodes_in_group("bombs"):
		match type:
			TOUCH.CHECKPOINT:
				Global.checkpoint = get_global_position()
				
				var e = checkpoint_particle.instantiate()
				get_parent().add_child(e)
				e.set_global_position(get_global_position())
				
			TOUCH.DOUBLE:
				var b = bomb.instantiate()
				get_parent().add_child(b)
				b.set_global_position(area.get_global_position())
				
				var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
				tween.tween_property(area, "position", area.get_position() + Vector2(0, -150), 0.5)
				tween.parallel().tween_property(b, "position", b.get_position() + Vector2(0, 150), 0.5)
				
				var e = double_particle.instantiate()
				get_parent().add_child(e)
				e.set_global_position(get_global_position())
				
		queue_free()
