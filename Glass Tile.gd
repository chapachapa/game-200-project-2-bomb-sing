extends StaticBody2D


#func on_damage():
	#var tween = get_tree().create_tween()
	#tween.tween_property($Sprite2D, "modulate", Color(Color.RED, 0.8), 0.2)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.modulate.a = 0.2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var tween = get_tree().create_tween()
	#tween.tween_property($Sprite2D, "modulate", Color(Color.WHITE, 0.4), 0.2)
	pass
