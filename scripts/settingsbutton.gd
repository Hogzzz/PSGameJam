extends Button




func _on_pressed():
	window.show()
	release_focus()


func _on_window_close_requested():
	window.hide()
