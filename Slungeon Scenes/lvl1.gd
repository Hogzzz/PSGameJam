extends Node2D
@onready var button = $Player/Camera2D/Button
@onready var pause_menu = $"Player/Camera2D/Pause Menu"
var paused = false

func _on_button_pressed():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

