extends OptionButton


func _on_item_selected(index):
	match index:
		0: #windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: #fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
