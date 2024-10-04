

extends Node3D

#@export var WEAPON_TYPE : Weapons:
	#set(value):
		#WEAPON_TYPE = value
		#if Engine.is_editor_hint():
			#load_weapon()
@export var CAMERA : Camera3D

@export var WEAPON: Array[Weapons]

var focused : int = 0
var current_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_weapon()

func nextWeapon():
	if focused >= WEAPON.size() - 1 :
		focused = 0
	else :
		focused += 1

func previousWeapon():
	if focused <= 0:
		focused = WEAPON.size() - 1
	else :
		focused -= 1
	
func _input(event):
	if event.is_action_pressed("next_weapon"):
		nextWeapon()
		load_weapon()
	if event.is_action_pressed("previous_weapon"):
		previousWeapon()
		load_weapon()
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
	if current_instance != null : 
		remove_child(current_instance)
	current_instance = WEAPON[focused].weaponScene.instantiate()
	add_child(current_instance)
	print(str(get_child_count()))
	position = WEAPON[focused].position
	rotation_degrees = WEAPON[focused].rotation
	
func attack():
	pass
	

	
