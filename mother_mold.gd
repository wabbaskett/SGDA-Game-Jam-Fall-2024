extends Area3D

@onready var moldRadius = $MoldCollision.shape.radius




func _on_mob_timer_timeout() -> void:
	spawn_mob()

func _on_growth_timer_timeout() -> void:
	moldRadius += .05
	$MoldCollision/MeshInstance3D.mesh.bottom_radius = moldRadius


func spawn_mob():
	var mob_scene = preload("res://test_mob.tscn") #WONT WORK WHEN WE EXPORT AS AN EXE
	var mob_instance = mob_scene.instantiate()

	var newMobPosition: Vector3

	var xPosition = randf_range(-moldRadius, moldRadius)
	var zPosition = randf_range(-moldRadius, moldRadius)
	newMobPosition = Vector3(xPosition, 0, zPosition).normalized() 
	newMobPosition *= randf_range(-moldRadius, moldRadius)
	newMobPosition.y = 10
	
	mob_instance.position = transform.origin
	
	
	
	
	print("Mob Spawned")
	get_tree().current_scene.add_child(mob_instance)
	

	
