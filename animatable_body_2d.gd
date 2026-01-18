extends AnimatableBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $CollisionShape2D/AnimationPlayer

func _ready():
	# Start both animations together
	animated_sprite_2d.play()
	animation_player.play("collision_anim")
