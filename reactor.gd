extends Node2D
@onready var killzone: Area2D = $ON/killzone
@onready var on_sprite = $ON
@onready var off_sprite = $OFF
@onready var detector: Area2D = $detector
@onready var sfx: AudioStreamPlayer2D = $SwitchSFX
@onready var timer: Timer = $Timer
@onready var block_collider: CollisionShape2D = $ON/killzone/CollisionShape2D
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

	#  Play sound EVERY TIME reactor turns ON
	if is_on:
		sfx.play()

	if is_on:
		# Wait one physics frame so detector updates first
		await get_tree().physics_frame

		var bodies = detector.get_overlapping_bodies()
		something_inside = bodies.size() > 0

		print("ON triggered (delayed) | something_inside =", something_inside)

		if something_inside:
			sfx.play()


func update_state():
	on_sprite.visible = is_on
	off_sprite.visible = !is_on

	# Proper killzone enable / disable
	killzone.monitoring = is_on
	killzone.monitorable = is_on
	block_collider.disabled = !is_on


func _on_body_entered(body):
	something_inside = true
	print("Something inside detector ✅")

func _on_body_exited(body):
	something_inside = false
	print("Detector empty ❌")
