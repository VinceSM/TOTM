extends Panel

func setPosition(position: int):
	$Position.text = str(position)

func setNamePlayer(NamePlayer: String):
	$NamePlayer.text = NamePlayer

func setScore(score: int):
	$Score.text = str(score)
