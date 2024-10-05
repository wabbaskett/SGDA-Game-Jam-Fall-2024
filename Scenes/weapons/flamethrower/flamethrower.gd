extends Node3D

var WEAPON_CAM : Camera3D
var WEAPON_RIG : Node3D

@export var hitbox : Area3D
@export var hitbox_offset : Vector3
@export var hitbox_rotation : Vector3
@export var hitbox_scale : Vector3
@export var flame_timer: Timer
@export var WEAPON_DATA : Weapon_Data
@export var flame_particles : GPUParticles3D

var max_ammo : int
var ammo

signal on_cooldown(duration, disable_weapon_for_duration)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WEAPON_RIG = get_parent().get_parent()
	WEAPON_CAM = WEAPON_RIG.get_parent()
	#print(WEAPON_CAM)
	max_ammo = WEAPON_DATA.ammo
	ammo = max_ammo
	call_deferred("orient_hitbox") #Have to wait a frame for the Weapon rig to get to the right spot
	print(WEAPON_DATA)
	#print(hitbox.global_position)
	#orient_hitbox()

func has_ammo() -> bool : 
	if ammo < 0 :
		return false
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("attack") :
		flame_timer.start()
		flame_particles.emitting = true
	if Input.is_action_just_released("attack") :
		flame_timer.stop()
		flame_particles.emitting = false
		

func orient_hitbox() :
	hitbox.global_transform = WEAPON_RIG.global_transform
	hitbox.position += hitbox_offset
	hitbox.rotation_degrees = hitbox_rotation
	hitbox.scale = hitbox_scale
	print(hitbox.scale)
	#hitbox.scale *= hitbox_scale


func _on_timer_timeout() -> void:
	if has_ammo() : 
		ammo -= 1
		print(ammo)
		var enemies = hitbox.get_overlapping_bodies()
		for e in enemies :
			e.health -= WEAPON_DATA.damage
	else :
		on_cooldown.emit(WEAPON_DATA.cooldownTime, true)
