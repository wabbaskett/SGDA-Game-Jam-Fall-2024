extends TextEdit

# gets UI node, gets Character node, gets Level node, 
@onready var collectibles_node : Node3D = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("./Collectibles")
@export var total : int = 10
@export var num_collected : int = 0

signal won

func _ready() :
	if (collectibles_node) :
		collectibles_node.collected2.connect(_on_collection)


func _on_collection() : 
	num_collected += 1
	self.text = "Collectibles: " + str(num_collected) + " / " + str(total)
	if num_collected == 10 :
		emit_signal("won")
