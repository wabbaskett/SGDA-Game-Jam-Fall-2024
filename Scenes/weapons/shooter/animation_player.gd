extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Shoot"):
		print("shooting")
		stop()
		play("shoot")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
