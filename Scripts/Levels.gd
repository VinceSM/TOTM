extends Node2D

func _ready():
	$SongLevel.play()

export (int) var nextLevel

func get_next_level():
	return nextLevel

