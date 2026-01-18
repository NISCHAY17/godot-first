extends Node

@onready var label_for_only: Label = $"LABLE FOR ONLY"

func _ready():
	randomize()
	label_for_only.text = "ORIGIN IP: " + fake_ip()

func fake_ip() -> String:
	return "%d.%d.%d.%d" % [
		randi_range(10, 250),
		randi_range(0, 255),
		randi_range(0, 255),
		randi_range(1, 254)
	]
