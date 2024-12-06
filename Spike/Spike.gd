#Spike.gd
extends Area2D

# Evento que se activa cuando el cuerpo de otro objeto (body) 
# entra en el área de colisión
func _on_Spike_body_entered(body):
	if body.get_name() == "Player":
		$deadSound.pitch_scale = 1.5
		$deadSound.play()
		body.die()
		_restart_game()

# Reinicia el juego y restablece los datos
func _restart_game():	
	GameManager.reset_data()  
