extends StaticBody2D

var fadeVolume = 0.6;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.volume > fadeVolume: 
		$CollisionShape2D.disabled = true
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D, "modulate", Color(Color.RED, 0.0), 0.2)
	else:
		$CollisionShape2D.disabled = false
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D, "modulate", Color(Color.WHITE,1.0), 0.2)
	
	pass
