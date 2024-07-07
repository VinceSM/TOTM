extends Area2D

func _ready():
	pass # Replace with function body.


func _on_Portal_body_entered(body):
	if body.get_name() == "Player":
		queue_free()
