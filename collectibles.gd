extends Node3D

@export var audio_player : AudioStreamPlayer

signal collected2

func _on_collected() :
	audio_player.play()
	emit_signal("collected2")
