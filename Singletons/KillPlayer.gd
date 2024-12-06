extends Node

var deadSound: AudioStreamPlayer2D

func _ready():
	deadSound = AudioStreamPlayer2D.new()
	deadSound.stream = preload("res://Sounds/sfxDead/deadPlayer.mp3")
	add_child(deadSound)

func kill_player(player: Node):
	if player.is_in_group("Player") and player.has_method("die"):
		deadSound.pitch_scale = 1.5
		deadSound.play()
		player.die()
		call_deferred("_restart_game")

func _restart_game():
	GameManager.reset_data()
