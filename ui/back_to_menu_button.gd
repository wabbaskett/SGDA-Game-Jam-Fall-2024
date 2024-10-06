extends Button

signal back_to_menu

func _on_pressed() :
	emit_signal("back_to_menu")
