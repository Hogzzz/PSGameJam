extends Node2D


# Called when the node enters the scene tree for the first time.
const Speed = 500

func _process(delta):
	var axis = Input.get_axis("move_left","move_right")
	position.x += axis * Speed * delta
	
