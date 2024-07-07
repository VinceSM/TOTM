extends CanvasLayer

var coins = 0
var portals = 0

func _ready():
	
	$PortalsCollectedTxt.text = String (portals)
	$CoinsCollectedTxt.text = String (coins)

func handleCoinCollected():
	print("coin collected")
	coins+=1
	$CoinsCollectedTxt.text = String(coins)
	
func handlePortalCollected():
	print("portal Collected")
	portals +=1
	$PortalsCollectedTxt.text = String (portals)
