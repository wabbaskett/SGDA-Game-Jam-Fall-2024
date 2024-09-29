@tool

extends Node3D

@export var WEAPON_TYPE : Weapons:
	set(value):
		WEAPON_TYPE = value
		if Engine.is_editor_hint():
			load_weapon()

@onready var weapon_mesh : MeshInstance3D = %WeaponMesh

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print_debug("weapon mesh is: " + weapon_mesh.name)
	load_weapon()

func _input(event):
	if event.is_action_pressed("weapon1"):
		WEAPON_TYPE = load("res://meshes/weapons/scrubber/scrubber.tres")
		load_weapon()
	if event.is_action_pressed("weapon2"):
		WEAPON_TYPE = load("res://meshes/weapons/shooter/shooter.tres")
		load_weapon()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_weapon() -> void:
	weapon_mesh.mesh = WEAPON_TYPE.mesh
	position = WEAPON_TYPE.position
	rotation_degrees = WEAPON_TYPE.rotation
