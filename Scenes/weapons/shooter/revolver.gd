extends Node3D

var CAMERA : Camera3D
var WEAPON_RIG : Node3D

@export var WEAPON_DATA : Weapon_Data
@export var muzzle_flash : GPUParticles3D
@export var smoke : GPUParticles3D
@export var smoke_timer : Timer
@export var attack_timer : Timer

var can_attack: bool = true

signal revolverAttack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WEAPON_RIG = get_parent().get_parent()
	CAMERA = WEAPON_RIG.get_parent()
	attack_timer.wait_time = WEAPON_DATA.attackTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and can_attack :
		revolverAttack.emit()
		rayscan_attack()
		attack_timer.start()
		can_attack = false
		if muzzle_flash.emitting :
			muzzle_flash.restart()
		else :
			muzzle_flash.emitting = true
		smoke.emitting = false
func _smoke() :
	smoke.emitting = true
	smoke_timer.start()

func _on_timer_timeout() -> void:
	smoke.emitting = false

func _on_attack_timer_timeout() -> void:
	can_attack = true

func rayscan_attack() :
	var space_state = CAMERA.get_world_3d().direct_space_state
	var screen_center = get_viewport().size / 2
	print(str(screen_center))
	var origin = CAMERA.project_ray_origin(screen_center)
	var endpoint = origin + CAMERA.project_ray_normal(screen_center) * WEAPON_DATA.range
	var bullet = PhysicsRayQueryParameters3D.create(origin, endpoint)
	bullet.collision_mask = 0b10
	bullet.collide_with_areas = false
	var result = space_state.intersect_ray(bullet)
	if result.size() != 0 :
		result["collider"].health -= WEAPON_DATA.damage
	print(str(result))
