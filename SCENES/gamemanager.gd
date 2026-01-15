extends Node

var score = 0
@onready var coinscore: Label = $COINSCORE

func add_point():
	score += 1
	print(score)
	coinscore.text = "You Collected" + str(score) + " coins "
