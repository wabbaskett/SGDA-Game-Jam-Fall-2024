extends Area3D

signal collected

@export var AUDIO_PLAYER : AudioStreamPlayer3D
@export var idle_audio : AudioStreamMP3

var cycle = 0

func _ready():
	AUDIO_PLAYER.stream = idle_audio
	AUDIO_PLAYER.autoplay = true
	AUDIO_PLAYER.playback_type = AudioServer.PLAYBACK_TYPE_STREAM
	AUDIO_PLAYER.play()

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D :
		emit_signal("collected")
		queue_free()

func _process(delta) :
	position.y += sin(cycle) * delta * 1.5
	cycle += PI/100
	if (cycle > 2 * PI) :
		cycle = 0
	rotation.y += .5 * delta
	
