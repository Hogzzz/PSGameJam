extends Button
@onready var window = $"../Window"




func _on_pressed():
	window.show()
	


func _on_window_close_requested():
	window.hide()
