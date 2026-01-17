extends Node

var score = 0
@onready var coinscore: Label = $COINSCORE
var collected_fruits := {}     
var all_fruits := []           
func add_point():
	score += 1
	print(score)
	coinscore.text = "You Collected" + str(score) + " coins "
