extends Area3D

signal collected

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D :
		emit_signal("collected")
		queue_free()
