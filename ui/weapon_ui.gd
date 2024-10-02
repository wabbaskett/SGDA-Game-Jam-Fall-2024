extends VBoxContainer

@export var WEAPON_SLOTS : Array[PanelContainer]
@export var scale_increase : float = 1.25

var focused : int = 0
var original_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	original_size = WEAPON_SLOTS[0].size
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
	focusSlot()

func previousSlot():
	defocusSlot()
	if focused <= 0:
		focused = WEAPON_SLOTS.size() - 1
	else :
		focused -= 1
	focusSlot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next_weapon"):
		nextSlot()
	elif Input.is_action_just_pressed("previous_weapon"):
		previousSlot()
		
		
