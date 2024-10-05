extends VBoxContainer

@export var WEAPON_SLOTS : Array[PanelContainer]
@export var scale_increase : float = 1.25

var enabled_array : Array[bool]
var focused : int = 0
var original_size : Vector2

signal end_cooldown(index)

# Called when the node enters the scene tree for the first time.
func _ready():
	original_size = WEAPON_SLOTS[0].size
	for e in WEAPON_SLOTS :
		enabled_array.append(true)
	focusSlot()

func defocusSlot():
	WEAPON_SLOTS[focused].custom_minimum_size = original_size

func focusSlot():
	WEAPON_SLOTS[focused].custom_minimum_size *= Vector2(scale_increase, scale_increase)
	
func nextSlot():
	defocusSlot()
	if focused >= WEAPON_SLOTS.size() - 1 :
		focused = 0
	else :
		focused += 1
	if not enabled_array[focused] :
		nextSlot()
	else :
		focusSlot()

func previousSlot():
	defocusSlot()
	if focused <= 0:
		focused = WEAPON_SLOTS.size() - 1
	else :
		focused -= 1
	if not enabled_array[focused] :
		previousSlot()
	else :
		focusSlot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next_weapon"):
		nextSlot()
	elif Input.is_action_just_pressed("previous_weapon"):
		previousSlot()
		
		



func _on_ui_startcooldown(index, duration, disable_weapon):
	enabled_array[index] = !disable_weapon
	if focused == index and disable_weapon:
		print("moving slots")
		previousSlot()
	

func _on_cooldown_bar_cooldown_done(index):
	if not enabled_array[index] :
		enabled_array[index] = true
	end_cooldown.emit(index)
