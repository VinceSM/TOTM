extends Panel
class_name ScoreEntry



func setPosition(position: int):
	$Position.text = str(position)

func setNamePlayer(NamePlayer: String):
	$NamePlayer.text = NamePlayer

func setScore(score: int):
	$Score.text = str(score)
