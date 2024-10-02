extends Node3D

@onready var moldRadius = $MoldArea/MoldCollision.shape.radius




func _on_mob_timer_timeout() -> void:
	spawn_mob()

func _on_growth_timer_timeout() -> void:
	moldRadius += .05
	$MoldArea/MoldCollision/MeshInstance3D.mesh.bottom_radius = moldRadius


func spawn_mob():
	var mob_scene = preload("res://test_mob.tscn")
	var mob_instance = mob_scene.instantiate()

	var newMobPosition: Vector3

	var xPosition = randf_range(-moldRadius, moldRadius)
	var zPosition = randf_range(-moldRadius, moldRadius)
	newMobPosition = Vector3(xPosition, 0, zPosition).normalized() 
	newMobPosition *= randf_range(-moldRadius, moldRadius)
	newMobPosition.y = $MoldArea.position.y + 1.5
	
	mob_instance.position = newMobPosition + transform.origin
	
	
	
	
	print("Mob Spawned")
	get_tree().current_scene.add_child(mob_instance)
