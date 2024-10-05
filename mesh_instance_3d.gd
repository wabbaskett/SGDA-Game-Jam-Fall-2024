extends MeshInstance3D

var cycle = 0

func _process(delta) :
	position.y += sin(cycle) * delta * 1.5
	cycle += PI/100
	if (cycle > 2 * PI) :
		cycle = 0
	rotation.y += .5 * delta
	
