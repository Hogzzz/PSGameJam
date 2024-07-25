extends Window
@onready var window = $"."

#signal exit_options_menu

func _ready():
	pass
	#exit.button_down.connect(on_exit_pressed)
	#set_process(false)
	
#func on_exit_pressed() -> void:
	#exit_options_menu.emit()
	#set_process(false)


func _on_exit_pressed():
	window.hide()

