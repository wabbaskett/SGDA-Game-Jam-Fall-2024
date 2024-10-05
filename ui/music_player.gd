extends AudioStreamPlayer

@export var music_playlist : Array[AudioStreamMP3]
@export var transition_song : AudioStreamMP3
@export var end_playlist : Array[AudioStreamMP3]

var is_beginning = true
var is_middle = false
var is_end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_pick_song()
	
func _pick_song() :
	if is_beginning :
		_pick_beginning_song()
	elif is_middle :
		_transition()
	else :
		_ending()

func _pick_beginning_song() :
	var index = randi_range(0, music_playlist.size()-1)
	stream = music_playlist[index]
	play()
	music_playlist.remove_at(index)
	if music_playlist.size() <= 0 :
		is_beginning = false
		is_middle = true

func _transition() : 
	stream = transition_song
	play()
	is_middle = false
	is_end = true
	
func _ending() : 
	var index = randi_range(0, end_playlist.size()-1)
	stream = end_playlist[index]
	play()
	end_playlist.remove_at(index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_finished():
	_pick_song()
