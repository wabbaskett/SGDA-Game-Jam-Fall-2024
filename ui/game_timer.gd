extends Timer

signal lost

@onready var check_win = $"../../../Collectibles/TextEdit"

func _ready() :
	if check_win:
		check_win.won.connect(_on_win)

func _on_win() :
	self.paused = true
	$"../../../WinLabel".visible = true
	$"../1SecTimer".paused = true

func _on_timeout() -> void:
	emit_signal("lost")
	$"../1SecTimer".paused = true
	$"../../../LoseLabel".visible = true
