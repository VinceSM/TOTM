extends Node

var coins = 0
var portals = 0
var total_coins = 0
 

func add_coin():
	coins += 1
	total_coins += 1

func add_portal():
	portals += 1

func reset_data():
	coins = 0
	portals = 0

func get_total_coins():
	return total_coins


