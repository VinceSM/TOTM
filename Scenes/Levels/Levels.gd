extends Node2D

export (int) var nextLevel
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_next_level():
	return nextLevel

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
