extends Node3D

@onready var moldRadius = $MoldArea/MoldCollision.shape.radius

@export var MOLD_MOB : PackedScene
@export var MOLD_NODE : PackedScene
@export var min_first_level_nodes : int = 3

var connected_nodes : Array[Node]
var connected_nodes_index : Array[int]

signal delegate_spawning(index, to_spawn, local_position)

func _on_mob_timer_timeout() -> void:
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
	return Vector3(xPosition, 0, zPosition).normalized() * randf_range(-moldRadius, moldRadius)
	
func get_random_position_at_edge() -> Vector3:
	var xPosition = randf_range(-moldRadius, moldRadius)
	var zPosition = randf_range(-moldRadius, moldRadius)
	return Vector3(xPosition, 0, zPosition).normalized() * moldRadius

func append_node(to_add : Node3D) : 
	connected_nodes.append(to_add)
	connected_nodes_index.append(to_add.get_index())
	to_add.connect("append_node", Callable(self, "append_node"))

func get_avg_node_direction() -> Vector3 :
	var avg_direction : Vector3 = Vector3(0,0,0)
	for e : Node3D in connected_nodes :
		avg_direction += e.global_position
		
	return (avg_direction / connected_nodes.size()).normalized()
		
#Returns one node out of the top RANGE nodes
func get_rand_from_furthest_nodes(range : int) -> Node3D :
	var max_distance = 0
	var max_nodes : Array[Node3D]
	for e : Node3D in connected_nodes :
		var squared_distance = e.global_position.distance_squared_to(global_position)
		if squared_distance > max_distance :
			#print("new max")
			max_nodes.append(e)
			if max_nodes.size() > range :
				max_nodes.erase(max_nodes.front())
			max_distance = squared_distance
			randi
				
	return max_nodes[randi_range(0, max_nodes.size() - 1)]

#Finds the furthest node in the opposite direction of the avg node direction within a given acceptance range, returns null if none found
func find_furthest_node_from_avg() -> Node3D :
		print(get_avg_node_direction())
		var direction = get_avg_node_direction() * -1
		print(direction)
		var global_direction = global_position + direction
		var min_angle = 2*PI
		var acceptance = 15.0
		var max_distance = 0
		var max_node = null
		for e : Node3D in connected_nodes :
			var squared_distance = e.global_position.distance_squared_to(global_direction)
			if e.global_position.angle_to(global_direction) < acceptance :
				if squared_distance > max_distance :
					#print("new max")
					max_node = e
					max_distance = squared_distance
					
		return max_node

func spawn_node():
	if connected_nodes.size() < min_first_level_nodes : 
		connected_nodes.append(handle_spawning(MOLD_NODE, get_random_position_at_edge() + Vector3(0, $MoldArea.position.y + 1.5, 0)))
		connected_nodes.back().connect("append_node", Callable(self, "append_node"))
		connected_nodes_index.append(connected_nodes.back().get_index())
		print(connected_nodes_index.back())
	else : 
		var to_spawn
		if randi_range(0, 4) == 0 :
			to_spawn = find_furthest_node_from_avg()
		else :
			to_spawn = get_rand_from_furthest_nodes(3)
		delegate_spawning.emit(to_spawn.get_index(), MOLD_NODE, get_random_position_at_edge() * moldRadius)
		#print("Time to search")
		## Find the furthest
		#for e : Node3D in min_nodes :
			#var squared_distance = e.global_position.distance_squared_to(global_direction)
			#print("Distance is: " + str(squared_distance) + " > " + str(max_distance))
			#if squared_distance > max_distance :
				#print("new max")
				#max_node = e
				#max_distance = squared_distance
		
	
	
