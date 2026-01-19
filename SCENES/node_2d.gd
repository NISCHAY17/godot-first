extends Node2D

@onready var coins_label: Label  = $CoinsLabel
@onready var fruits_label: Label = $FruitsLabel

func _ready():
	update_display()

func _process(delta):
	update_display()

func update_display():
	coins_label.text  = "COINS: " + str(Gamemanager.score)
	fruits_label.text = "FRUITS: " + str(Gamemanager.total_fruits)
