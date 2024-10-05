extends CanvasLayer
class_name UI

@export var health_bar: TextureProgressBar

@onready var objective_label = %Objective
@onready var hours_label = %HoursTimer
@onready var mins_label = %MinutesTimer
@onready var secs_label = %SecondsTimer

@export var minutes_time_limit : float

signal startcooldown(index, duration, disable_weapon)
signal end_cooldown(index)

var secs_passed: int
var mins_passed: int
var hours_passed: int
var time_limit_ms : int
# Called when the node enters the scene tree for the first time.
func _ready():
	time_limit_ms = minutes_time_limit * 60 * 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	var time_left_ms = time_limit_ms - Time.get_ticks_msec()
	var time_left_sec = time_left_ms / 1000
	
	secs_passed = time_left_sec % 60
	mins_passed = time_left_sec / 60
	#hours_passed = mins_passed / 60
	
	secs_label.text = str(secs_passed % 60) + "s" 
	mins_label.text = str(mins_passed) + "m" if (mins_passed > 0) else ""
	hours_label.text = str(hours_passed) + "h" if (hours_passed > 0) else ""


func _on_character_update_health(change: int, max_health : int):
	health_bar.value += change
	health_bar.max_value = max_health


func _on_weapon_on_cooldown(index, duration, disable_weapon):
	startcooldown.emit(index, duration, disable_weapon)


func _on_weapons_end_cooldown(index):
	end_cooldown.emit(index) # Replace with function body.
