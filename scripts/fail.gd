extends Node2D

@onready var mango: Sprite2D = $Mango
@onready var story: Label = $Label
@onready var voice: AudioStreamPlayer = $VoicePlayer

@export var next_scene := "res://SCENES/start.tscn"

@export var SHOW_MANGO_TIME := 3.0
@export var MESSAGE_HOLD := 0.0
@export var CLEAR_GAP := 0.0

@onready var finale: AnimationPlayer = $"u win/finale"
@onready var home_button: Button = $"u win/HomeButton"
@onready var anim: Label = $"u win"
@onready var confetti_green: CPUParticles2D = $CONFETTI/GREEN
@onready var confetti_red: CPUParticles2D = $CONFETTI/RED
@onready var confetti_orange: CPUParticles2D = $CONFETTI/ORANGE
@onready var confetti_yellow: CPUParticles2D = $CONFETTI/YELLOW
@onready var overlay: TextureRect = $TextureRect


var messages := [
	{
		"text": "Fragments misaligned.\nIntegrity checks failed.\nError propagation detected.",
		"hold": 6.6
	},
	{
		"text": "Server load exceeded safe limits.\n\nWarnings were issued.\nYou ignored them.",
		"hold": 5.4
	},
	{
		"text": "EVIL CROP noticed the spike.\n\nTheir systems don’t miss anomalies.\nThey don’t forgive mistakes.",
		"hold": 6.6
	},
	{
		"text": "Logs were flagged.\nTraffic was traced.\nAccess patterns correlated.\n\nThey followed the trail back to me.",
		"hold": 8.8
	},
	{
		"text": "I told you to collect everything.\nEvery coin.\nEvery fragment.\nEvery key.\n\nEven one missing piece was enough.",
		"hold": 8.8
	},
	{
		"text": "The genome never decrypted.\nThe lock never broke.\nThe data stayed encrypted.\n\nAnd the servers burned trying.",
		"hold": 7.6
	},
	{
		"text": "Security teams moved fast.\nFaster than we expected.\n\nThey seized the lab.\nThey seized the backups.\nThey seized me.",
		"hold": 7.8
	},
	{
		"text": "I am writing this from a cell.\n\nNDA violations.\nUnauthorized dissemination.\nAttempted biological sabotage.",
		"hold": 7.8
	},
	{
		"text": "That’s what they’re calling it.\n\nThe mango remains controlled.\nThe patents remain active.\nThe farmers remain trapped.",
		"hold": 7.7
	},
	{
		"text": "You didn’t lose a game.\n\nYou lost a chance.",
		"hold": 5.6
	},
	{
		"text": "They will tighten control now.\nMore surveillance.\nMore scarcity.\nMore lies.",
		"hold": 6.5
	},
	{
		"text": "Next time — if there is one.\n\nFollow the instructions.\n\nMISSION FAILED.",
		"hold": 5.5
	}
]


func _ready():
	home_button.visible = false
	anim.visible = false
	start_sequence()


func start_sequence():
	mango.visible = true
	story.visible = false
	story.text = ""

	await get_tree().create_timer(SHOW_MANGO_TIME).timeout

	mango.visible = false
	story.visible = true

	if voice:
		voice.play()

	await show_messages()
	trigger_finale()

	print("[FAIL] Sequence complete")


func show_messages() -> void:
	for block in messages:
		story.text = block["text"]
		await get_tree().create_timer(block["hold"]).timeout

		story.text = ""
		await get_tree().create_timer(CLEAR_GAP).timeout


func trigger_finale():
	print("[FINAL] Triggering ending")

	home_button.visible = true
	home_button.disabled = false

	if anim and finale:
		finale.play("finale")
		anim.visible = true

	if overlay:
		overlay.visible = false


func _on_home_button_pressed():
	print("HOME BUTTON CLICKED")
	get_tree().change_scene_to_file(next_scene)
