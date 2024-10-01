extends CanvasLayer
class_name UI

@onready var objective_label = %Objective
@onready var hours_label = %HoursTimer
@onready var mins_label = %MinutesTimer
@onready var secs_label = %SecondsTimer

var secs_passed: int
var mins_passed: int
var hours_passed: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	secs_passed = Time.get_ticks_msec() / 1000
	mins_passed = secs_passed / 60
	hours_passed = mins_passed / 60
	
	secs_label.text = str(secs_passed % 60) + "s" 
	mins_label.text = str(mins_passed) + "m" if (mins_passed > 0) else ""
	hours_label.text = str(hours_passed) + "h" if (hours_passed > 0) else ""
