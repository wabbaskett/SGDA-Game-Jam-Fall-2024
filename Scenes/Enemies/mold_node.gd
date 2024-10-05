extends Node3D

var node_index : int

signal append_node(to_append)

# Called when the node enters the scene tree for the first time.
func _ready():
	node_index = get_index()
	
	#print(get_tree().root.get_tree_string_pretty())
	find_parent("MotherMold").connect("delegate_spawning", Callable(self, "handle_spawning"))

func handle_spawning(index, to_spawn, local_position):
	#print("Checking if need to spawn")
	if index == node_index :
		print("Going to spawn")
		var spawning = to_spawn.instantiate()
		spawning.position = local_position + position
		add_sibling(spawning)
		append_node.emit(spawning)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
