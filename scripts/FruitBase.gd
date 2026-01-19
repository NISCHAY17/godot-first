extends AnimatableBody2D

@export var fruit_id := ""
@export var fruit_name := ""


func _ready():
	if fruit_id not in Gamemanager.all_fruits:
		Gamemanager.all_fruits.append(fruit_id)

func _on_body_entered(body):
	if body.name == "Player":
		collect()

func collect():
	Gamemanager.collected_fruits[fruit_id] = true
	print("Collected:", fruit_name)
	queue_free()
