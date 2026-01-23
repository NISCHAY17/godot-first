extends Node

var score := 0
var total_fruits := 0
var keys := 0   #KEYS SUPPORT

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

func add_key():
	keys += 1
	print("[GAME] Keys =", keys)
	
func reset():
	score = 0
	total_fruits = 0
	keys = 0
	collected_fruits.clear()
	all_fruits.clear()
	print("[GAME] 🔄 GameManager reset")
