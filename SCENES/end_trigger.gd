extends Area2D

@export var next_scene: String = "res://SCENES/final.tscn"

#  Drag your Player node here in the Inspector
@export var player: Node

var triggered := false

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

	print("[EndTrigger] Ready")
	print("[EndTrigger] Player ref =", player)
	print("[EndTrigger] Next scene =", next_scene)

func _on_body_entered(body):
	print("[EndTrigger] Body entered:", body)

	if triggered:
		return

	if body != player:
		print("[EndTrigger] Not player — ignoring")
		return

	triggered = true
	print("[EndTrigger]  Player detected → Loading next scene")


	get_tree().change_scene_to_file(next_scene)
