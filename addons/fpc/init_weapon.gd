

extends Node3D

#@export var WEAPON_TYPE : Weapons:
	#set(value):
		#WEAPON_TYPE = value
		#if Engine.is_editor_hint():
			#load_weapon()
@export var CAMERA : Camera3D

@export var WEAPON: Array[Weapons]

var enabled_array : Array[bool]
var focused : int = 0
var current_instance

signal grapple_equipped
signal grapple_dequipped
signal on_cooldown(index, duration, disable_weapon)

# Called when the node enters the scene tree for the first time.
func _ready():
	for e in WEAPON :
		enabled_array.append(true)
	load_weapon()

func nextWeapon():
	if focused >= WEAPON.size() - 1 :
		focused = 0
	else :
		focused += 1
	if not enabled_array[focused] :
		nextWeapon()
	else :
		load_weapon()

func previousWeapon():
	if focused <= 0:
		focused = WEAPON.size() - 1
	else :
		focused -= 1
	if not enabled_array[focused] :
		previousWeapon()
	else :
		load_weapon()
	
func _input(event):
	pass
	#if event.is_action_pressed("next_weapon"):
		#nextWeapon()
	#if event.is_action_pressed("previous_weapon"):
		#previousWeapon()
#
#func _input(event):
	#if event.is_action_pressed("weapon1"):
		#WEAPON_TYPE = load("res://meshes/weapons/scrubber/scrubber.tres")
		#load_weapon()
	#if event.is_action_pressed("weapon2"):
		#WEAPON_TYPE = load("res://meshes/weapons/shooter/shooter.tres")
		#load_weapon()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_weapon():
	if enabled_array[focused] :
		if current_instance != null : 
			remove_child(current_instance)
		current_instance = WEAPON[focused].weaponScene.instantiate()
		#current_instance.connect("on_cooldown", Callable(self, "enter_cooldown"))
		add_child(current_instance)
		if focused == 0 : 
			grapple_equipped.emit()
		else : 
			grapple_dequipped.emit()
		print(str(get_child_count()))
		position = WEAPON[focused].position
		rotation_degrees = WEAPON[focused].rotation
	
func enter_cooldown(duration : float, disable_weapon_for_duration : bool) :
	on_cooldown.emit(focused, duration, disable_weapon_for_duration)
	if disable_weapon_for_duration :
		enabled_array[focused] = false
		previousWeapon()
	
func attack():
	pass

func _on_end_cooldown(index):
	pass
	#enabled_array[index] = true
