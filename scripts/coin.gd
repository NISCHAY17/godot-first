extends Area2D


# Called when the node enters the scene tree for the first time.
@onready var gamemanager: Node = %gamemanager
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_body_entered(body: Node2D) -> void:
	gamemanager.add_point()
	animation_player.play("COINPICK")
	queue_free()
