extends Node2D

@onready var on_sprite = $ON
@onready var off_sprite = $OFF
@onready var detector: Area2D = $Detector
@onready var sfx: AudioStreamPlayer2D = $SwitchSFX
@onready var timer: Timer = $Timer
@onready var block_collider: CollisionShape2D = $killzone/CollisionShape2D

var is_on := false
var something_inside := false

func _ready():
	update_state()
	timer.timeout.connect(toggle_state)

	detector.body_entered.connect(_on_body_entered)
	detector.body_exited.connect(_on_body_exited)

func toggle_state():
	is_on = !is_on
	update_state()

	# 🔊 Play sound when turning ON and something is inside detector
	if is_on and something_inside:
		print("SFX PLAY ✅")
		sfx.play()

func update_state():
	# Visuals
	on_sprite.visible = is_on
	off_sprite.visible = !is_on

	# 🚧 Collision logic
	# ON  → disable collider (player can pass)
	# OFF → enable collider (blocked)
	block_collider.disabled = is_on

func _on_body_entered(body):
	something_inside = true
	print("Something inside detector")

func _on_body_exited(body):
	something_inside = false
	print("Detector empty")
