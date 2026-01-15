extends Node2D

const SPEED = 60
# Called when the node enters the scene tree for the first time.
var direction = 1
func _ready() -> void:
	pass # Replace with function body.
@onready var ray_castright_right: RayCast2D = $RayCastrightRIGHT
@onready var ray_castright_2left: RayCast2D = $RayCastright2LEFT
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_castright_2left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	if ray_castright_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	position.x += direction * SPEED * delta
