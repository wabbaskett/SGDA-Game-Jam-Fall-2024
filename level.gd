extends Node3D

@onready var back_to_menu_button = get_child(0).get_node("./UI").get_child(0).get_node("./LoseLabel").get_child(0)
@onready var back_to_menu_button1 = get_child(0).get_node("./UI").get_child(0).get_node("./WinLabel").get_child(0)

func _ready() :
	if back_to_menu_button :
		back_to_menu_button.back_to_menu.connect(_on_lose)
		back_to_menu_button1.back_to_menu.connect(_on_lose)

func _on_lose() :
	print("This is working")
	$"../Main Menu".show()
	queue_free()
