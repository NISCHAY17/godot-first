extends Node

var score := 0
var total_fruits := 0

# unique fruit IDs
var collected_fruits := {}
var all_fruits := []

func add_point():
	score += 1
	print("[GAME] Coins =", score)

func add_fruit(fruit_id: String):
	if not collected_fruits.has(fruit_id):
		collected_fruits[fruit_id] = true
		total_fruits += 1
		print("[GAME] Fruit collected:", fruit_id, "| Total:", total_fruits)
