extends AnimatableBody2D

@export var fruit_id := ""
@export var fruit_name := ""
@onready var gamemanager: Node = %gamemanager

func _ready():
	if fruit_id not in gamemanager.all_fruits:
		gamemanager.all_fruits.append(fruit_id)

func _on_body_entered(body):
	if body.name == "Player":
		collect()

func collect():
	gamemanager.collected_fruits[fruit_id] = true
	print("Collected:", fruit_name)
	queue_free()
