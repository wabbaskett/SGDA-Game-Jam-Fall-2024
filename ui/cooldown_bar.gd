extends TextureProgressBar

@export var index : int 

var degress_per_second : float
var cooldown_active = false

signal cooldown_done(index)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown_active : 
		print(str(value) + " - " + str(degress_per_second * delta))
		value -= degress_per_second * delta # Working backwards
		
	if value <= min_value : 
		cooldown_active = false
		cooldown_done.emit(index)
		value = 0


func _on_ui_startcooldown(index, duration, ignore):
	if index == self.index :
		print(str(index) + " is out of ammo")
		print(duration)
		degress_per_second = (max_value / duration)
		value = max_value
		cooldown_active = true
