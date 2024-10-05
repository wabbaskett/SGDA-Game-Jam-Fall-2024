extends CharacterBody3D

@export var health_bar: TextureProgressBar

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var health = 100

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	health_bar.value = health
	if health <= 0: 
		queue_free()
