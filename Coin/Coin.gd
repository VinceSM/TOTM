# Coin.gd 
extends Area2D

func _on_Coin_body_entered(body):
	CollectibleBehavior.handle_collection(self, body, $sfxCoinCollected, "add_coin")
