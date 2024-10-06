extends Button

signal back_to_menu


func _on_pressed() :
	emit_signal("back_to_menu")

func _on_visibility_changed():
	if visible :
		grab_focus()
