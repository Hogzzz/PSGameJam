extends Button

@onready var pause_menu = $"../.."
var paused = true

func _on_pressed():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
	release_focus()
