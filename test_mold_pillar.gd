extends Node3D

@onready var moldRadius = $MoldArea/MoldCollision.shape.radius

@export var MOLD_MOB : PackedScene
@export var MOLD_NODE : PackedScene

var connected_nodes : Array[Node]


func _on_mob_timer_timeout() -> void:
	spawn_mob()
	spawn_node()

func _on_growth_timer_timeout() -> void:
	moldRadius += .05
	$MoldArea/MoldCollision/MeshInstance3D.mesh.bottom_radius = moldRadius

func handle_spawning(to_spawn : PackedScene, spawn_position : Vector3) -> Node:
	var spawning = to_spawn.instantiate()
	spawning.position = spawn_position
	add_child(spawning)
	return spawning
	#print(str(get_tree().current_scene.get_child_count()))

func spawn_mob():
	handle_spawning(MOLD_MOB, get_random_position_in_radius())
	print("Mob Spawned")

func get_random_position_in_radius() -> Vector3:
	var xPosition = randf_range(-moldRadius, moldRadius)
	var zPosition = randf_range(-moldRadius, moldRadius)
	return (Vector3(xPosition, 0, zPosition).normalized() * randf_range(-moldRadius, moldRadius)) + Vector3(0, $MoldArea.position.y + 1.5, 0)

func spawn_node():
	connected_nodes.append(handle_spawning(MOLD_NODE, get_random_position_in_radius()))
	print(str(connected_nodes.size()) + " Nodes")
	
	
	
