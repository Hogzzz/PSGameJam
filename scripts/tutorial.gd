extends Node2D

@onready var pause_menu = $"Player/Camera2D/Pause Menu"
var paused = false


func _on_pause_pressed():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
