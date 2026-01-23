extends Area2D

@onready var timer: Timer = $Timer
@onready var death_sound: AudioStreamPlayer = $DeathSound

func _on_body_entered(body: Node2D):
	print("U DIED :(")
	Engine.time_scale = 0.5
	
	if death_sound:
		death_sound.play()
	


	
	var collision = body.get_node_or_null("CollisionShape2D")
	if collision:
		collision.disabled = true

	
	var sprite = body.get_node_or_null("AnimatedSprite2D")
	if sprite:
		sprite.modulate = Color(1, 0.2, 0.3167)

	timer.start()
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	Gamemanager.reset()

	print("reload")
