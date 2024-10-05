extends MeshInstance3D

var CHARACTER :CharacterBody3D

var hookpoint : Vector3
var grappling = false
var original_scale : Vector3

signal launch_grapple
signal stop_grapple

# Called when the node enters the scene tree for the first time.
func _ready():
	original_scale = scale
	CHARACTER = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()
	CHARACTER.connect("grapple_to", Callable(self, "_start_grapple"))
	CHARACTER.connect("grapple_end", Callable(self, "_stop_grapple"))

func _start_grapple(hookto : Vector3):
	visible = true
	hookpoint = hookto
	grappling = true
	launch_grapple.emit()

func _stop_grapple():
	visible = false
	grappling = false
	stop_grapple.emit()
	scale = original_scale
	

func _orient_rope():
	look_at_from_position(global_position, hookpoint)
	scale = Vector3(scale.x, scale.y, absf(global_position.distance_to(hookpoint)))
	#print(scale.z)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if grappling :
		_orient_rope()
