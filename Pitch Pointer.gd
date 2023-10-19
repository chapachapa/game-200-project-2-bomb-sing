extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


@export var Y_MAX = 715
@export var Y_MIN = 175
@export var X_POS = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y_mouse_pos = get_viewport().get_mouse_position().y;
	var y_vec = y_mouse_pos - self.position.y # getting the vector from self to the mouse
	# vec = vec.normalized() * delta * SPEED # normalize it and multiply by time and speed
	if(y_mouse_pos <= Y_MIN):
		position = Vector2(X_POS, Y_MIN)
	elif(y_mouse_pos >= Y_MAX):
		position = Vector2(X_POS, Y_MAX)
	else:
		position = Vector2(X_POS, position.y + y_vec) # move by that vector
