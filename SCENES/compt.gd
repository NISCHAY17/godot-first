extends Area2D

@export var next_scene := "res://computer_check.tscn"
@export var player: Node

var inside := false

	
func _ready():
	print(" FINAL SCENE LOADED")
	
	if not body_entered.is_connected(_on_enter):
		body_entered.connect(_on_enter)
	if not body_exited.is_connected(_on_exit):
		body_exited.connect(_on_exit)
		print(" FINAL SCENE LOADED")
	
func _on_enter(body):
	if body == player:
		inside = true
		print("[Computer] Player in range")

func _on_exit(body):
	if body == player:
		inside = false
		print("[Computer] Player left range")

func _process(delta):
	if inside and Input.is_action_just_pressed("ui_accept"):
		print("[Computer] Opening computer screen")

		get_tree().change_scene_to_file(next_scene)
		
