extends Node2D

@onready var mango: Sprite2D = $Mango
@onready var story: Label = $Label
@onready var voice: AudioStreamPlayer = $VoicePlayer

const START = preload("res://SCENES/start.tscn")
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
@onready var confetti_YELLOW: CPUParticles2D = $CONFETTI/YELLOW
@onready var overlay: TextureRect = $TextureRect

var messages := [
	{
		"text": "Genome fragments aligned.\nEncryption dissolved.\nSignal broadcasted globally.",
		"hold": 1.5
	},
	{
		"text": "For decades, EVIL CROP controlled food through artificial scarcity.\nThey patented life itself.\nEvery seed was tracked.\nEvery harvest was taxed.\nEvery farmer was owned.",
		"hold": 1.5
	},
	{
		"text": "You broke the lock.\n\nThe original genome has now been released worldwide.\nAnyone can grow real mangoes again.\nNo licenses. No restrictions. No control.",
		"hold": 1.0
	},
	{
		"text": "Fields will bloom where factories once ruled.\nSeeds will pass freely between hands.\nFood belongs to people again.",
		"hold": 1.0
	},
	{
		"text": "You didn’t just win a game.\nYou restored a future.\n\nTHE MANGO IS FREE.",
		"hold": 1.0
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

	print("[SUCCESS] Sequence complete")


func show_messages() -> void:
	for block in messages:
		story.text = block["text"]
		await get_tree().create_timer(block["hold"]).timeout

		story.text = ""
		await get_tree().create_timer(CLEAR_GAP).timeout


func trigger_finale():
	print("[FINAL] Triggering celebration")
	home_button.visible = true
	home_button.disabled = false

	
	if anim:
		finale.play("finale") 
		anim.visible = true  

	
	confetti_green.emitting = true
	confetti_red.emitting = true
	confetti_orange.emitting = true
	confetti_YELLOW.emitting = true
	
	
	if overlay:
		overlay.visible = false
		
func _on_home_button_pressed():
	print("HOME BUTTON CLICKED")
	get_tree().change_scene_to_file(next_scene)
