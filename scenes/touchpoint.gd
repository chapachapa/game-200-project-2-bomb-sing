extends Area2D

enum {TOUCH_CHECKPOINT, TOUCH_DOUBLE}
@export var type = 0

var bomb = preload("res://scenes/bomb.tscn")


func _ready():
	pass


func _on_body_entered(body):
	pass


func _on_area_entered(area):
	#print(area.name)
	if "Bomb" in area.name:
		Global.checkpoint = get_global_position()
		queue_free()
