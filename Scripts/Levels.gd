extends Node2D

export (int) var nextLevel
var song_player = null
export (int) var time_left = 40 

func set_time(seconds):
	time_left = seconds

func reduce_time():
	time_left -= 1
	return time_left

func _ready():
	if song_player == null:
		song_player = $SongLevel
		song_player.play()

	if not song_player.playing:
		song_player.play()

func get_next_level():
	return nextLevel
	



