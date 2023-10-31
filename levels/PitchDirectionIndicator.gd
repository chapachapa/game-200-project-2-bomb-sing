extends TextureRect

func on_beat(beat):
	set_scale(Vector2(3, 3) * 1.3)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($Sprite, "scale", Vector2(6, 6), 0.2)
