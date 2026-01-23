extends Node2D

@onready var button: Button = $Button


@export var next_scene := "res://SCENES/story.tscn"

func _ready():
	button.pressed.connect(_on_start_pressed)

func _on_start_pressed():
	print("START GAME")
	get_tree().change_scene_to_file(next_scene)
