extends AnimationPlayer

@export var grapple_sfx : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rope_launch_grapple():
	play("shoot")
	grapple_sfx.play()


func _on_rope_stop_grapple():
	stop()
	play("RESET")
