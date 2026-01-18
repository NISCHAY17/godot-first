extends Area2D

@export var next_scene := "res://SCENES/final.tscn"


var triggered := false

func _on_body_entered(body):
	if triggered:
		return

	if body.name == "PLAYER":
		triggered = true
		print("ENTER DONE")

		if body.has_method("freeze"):
			body.freeze()

		SceneTransition.fade_to_scene(next_scene, 1.5)
