extends Node3D

signal collected2

func _on_collected() :
	emit_signal("collected2")
