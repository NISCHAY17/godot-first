extends Node2D

@onready var mango: Sprite2D = $Mango
@onready var story: Label = $StoryLabel
@onready var voice: AudioStreamPlayer = $VoicePlayer

@export var SHOW_MANGO_TIME := 3.0
@export var MESSAGE_HOLD := 2.0
@export var CLEAR_GAP := 0.6


var messages := [
	{
		"text": "Genome fragments aligned.\nEncryption dissolved.\nSignal broadcasted globally.",
		"hold": 10.0
	},
	{
		"text": "For decades, EVIL CROP controlled food through artificial scarcity.\nThey patented life itself.\nEvery seed was tracked.\nEvery harvest was taxed.\nEvery farmer was owned.",
		"hold": 13.5
	},
	{
		"text": "You broke the lock.\n\nThe original genome has now been released worldwide.\nAnyone can grow real mangoes again.\nNo licenses. No restrictions. No control.",
		"hold": 13.0
	},
	{
		"text": "Fields will bloom where factories once ruled.\nSeeds will pass freely between hands.\nFood belongs to people again.",
		"hold": 12.5
	},
	{
		"text": "You didn’t just win a game.\nYou restored a future.\n\nTHE MANGO IS FREE.",
		"hold": 14.0
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

	print("[SUCCESS] Sequence complete")


func show_messages() -> void:
	for block in messages:
		story.text = block["text"]

		
		await get_tree().create_timer(block["hold"]).timeout

		
		story.text = ""

		
		await get_tree().create_timer(CLEAR_GAP).timeout
		
		await get_tree().create_timer(CLEAR_GAP).timeout
