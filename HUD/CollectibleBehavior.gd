extends Node

static func handle_collection(collectible: Area2D, body: Node, sound_node: AudioStreamPlayer, collection_method: String):
	if body.get_name() == "Player":
		body.call(collection_method)
		
		sound_node.pitch_scale = 1.5 
		sound_node.play()

		collectible.set_deferred("monitoring", false)
		collectible.set_deferred("collision_layer", 0)
		collectible.set_deferred("collision_mask", 0)
		collectible.visible = false
		
		collectible.get_tree().create_timer(0.5).connect("timeout", collectible, "queue_free")
