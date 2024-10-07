extends Node2D

export (int) var nextLevel
onready var song_player = $SongLevel

func _ready():
	if song_player:
		song_player.play()  

func get_next_level():
	return nextLevel
