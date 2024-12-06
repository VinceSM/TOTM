# FinalScene.gd
extends Node2D


func _on_btnScore_pressed():
	get_tree().change_scene("res://Score/Score.tscn")
