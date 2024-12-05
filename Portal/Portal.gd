# Portal.gd
extends Area2D

func _on_Portal_body_entered(body):
	CollectibleBehavior.handle_collection(self, body, $SongPortal, "add_portal")
	if body.get_name() == "Player":
		self.get_tree().create_timer(0.5).connect("timeout", self, "advance_to_next_level")

func advance_to_next_level():
	var next_level = get_parent().get_next_level()
	ChangeScene.change_scene("res://Levels/" + str(next_level) + ".tscn")
