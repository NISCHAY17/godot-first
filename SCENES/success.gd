extends Node2D

@onready var mango: Sprite2D = $Mango
@onready var story: Label = $StoryLabel
@onready var voice: AudioStreamPlayer = $VoicePlayer

# 🎬 Finale systems
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var confetti_green: CPUParticles2D = $CONFETTI/GREEN
@onready var confetti_red: CPUParticles2D = $CONFETTI/RED
@onready var confetti_orange: CPUParticles2D = $CONFETTI/ORANGE
@onready var overlay: TextureRect = $TextureRect   

@export var SHOW_MANGO_TIME := 3.0
@export var CLEAR_GAP := 0.4


var messages := [
	{
		"text": "Genome fragments aligned.\nEncryption dissolved.\nSignal broadcasted globally.",
		"hold": 7.5
	},
	{
		"text": "For decades, EVIL CROP controlled food through artificial scarcity.\nThey patented life itself.\nEvery seed was tracked.\nEvery harvest was taxed.\nEvery farmer was owned.",
		"hold": 14.5
	},
	{
		"text": "You broke the lock.\n\nThe original genome has now been released worldwide.\nAnyone can grow real mangoes again.\nNo licenses. No restrictions. No control.",
		"hold": 13.0
	},
	{
		"text": "Fields will bloom where factories once ruled.\nSeeds will pass freely between hands.\nFood belongs to people again.",
		"hold": 10.0
	},
	{
		"text": "You didn’t just win a game.\nYou restored a future.\n\nTHE MANGO IS FREE.",
		"hold": 13.0
	}
]


func _ready():
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

	print("[SUCCESS] Sequence complete")


func show_messages() -> void:
	for block in messages:
		story.text = block["text"]
		await get_tree().create_timer(block["hold"]).timeout

		story.text = ""
		await get_tree().create_timer(CLEAR_GAP).timeout


func trigger_finale():
	print("[FINAL] Triggering celebration")

	# ▶️ Play animation
	if anim:
		anim.play("finale")  

	
	confetti_green.emitting = true
	confetti_red.emitting = true
	confetti_orange.emitting = true

	# 🖼️ Hide overlay
	if overlay:
		overlay.visible = false
