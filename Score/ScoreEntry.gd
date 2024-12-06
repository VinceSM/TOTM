#ScoreEntry.gd
extends Panel

# Establece la posición del jugador en el panel
func setPosition(position: int) -> void:
	$Position.text = str(position)

# Establece el nombre del jugador en el panel
func setNamePlayer(namePlayer: String) -> void:
	$NamePlayer.text = namePlayer

# Establece la puntuación del jugador en el panel
func setScore(score: int) -> void:
	$Score.text = str(score)
