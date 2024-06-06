extends CanvasLayer

var coins = 0

func _ready():
	
	#var coinNode = get_tree().get_root().find_node("Coin2D",true,false)
	#coinNode.connect("coinCollected",self,"handleCoinCollected")
	
	$CoinsCollectedTxt.text = String (coins)

func handleCoinCollected():
	print("coin collected")
	coins+=1
	$CoinsCollectedTxt.text = String(coins)
