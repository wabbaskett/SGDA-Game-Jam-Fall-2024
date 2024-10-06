extends Control


@onready var buttons_v_box: VBoxContainer = %Buttons

@export var level_scene : PackedScene
var level_instance

func _on_start_button_pressed() -> void:
	if not level_instance:
		# If no level instance exists, instantiate and add it
		level_instance = level_scene.instantiate()
		add_sibling(level_instance)
	else:
		# If a level instance already exists, free the current one
		level_instance.queue_free()
		level_instance = level_scene.instantiate()
		add_sibling(level_instance)

	# Hide the button or UI element that was pressed
	hide()
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	focus_button()
	level_instance = level_scene.instantiate()

func _on_visbility_changed() -> void:
	if visible:
		focus_button()

func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()


func _on_visibility_changed():
	if visible:
		focus_button()
