extends Node2D

var paused = false
@onready var pause_menu = $"Player/Camera2D/Pause Menu"

func _on_button_pressed():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
