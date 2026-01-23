extends Node2D

@onready var label: Label = $Label

@export var next_scene := "res://SCENES/game.tscn"
@export var CLEAR_GAP := 0.3

var messages := [
	{
		"text": "Hi.",
		"hold": 1.5
	},
	{
		"text": "My name is Nischay.",
		"hold": 1.8
	},
	{
		"text": "I am a biological scientist in the year 2067.",
		"hold": 3.6
	},
	{
		"text": "I work for a corporation known only as EVIL CROP.",
		"hold": 4.5
	},
	{
		"text": "Officially, we research agricultural optimization.\nHigher yields.\nFaster growth.\nPerfect control.",
		"hold": 8.4
	},
	{
		"text": "Unofficially — they are trying to control the entire mango supply on Earth.",
		"hold": 6.8
	},
	{
		"text": "Every seed.\nEvery farm.\nEvery harvest.",
		"hold": 3.4
	},
	{
		"text": "Food has become leverage.",
		"hold": 2.5
	},
	{
		"text": "I am not allowed to talk about this.\nI signed an NDA that could end my life if I break it.",
		"hold": 6.6
	},
	{
		"text": "So I did something stupid.",
		"hold": 2.4
	},
	{
		"text": "I learned Godot.",
		"hold": 1.1
	},
	{
		"text": "I hid the biological genome of the original mango inside a simple jumper game.\nThe data is disguised as fruit.\nEach fragment is locked behind full coin collection.",
		"hold": 11.6
	},
	{
		"text": "If even one coin is missing, the genome stays encrypted.",
		"hold": 3.5
	},
	{
		"text": "This game is not a joke.",
		"hold": 2.0
	},
	{
		"text": "I don’t know how much time I have left.\nI think EVIL CROP is getting close to me.",
		"hold": 5.2
	},
	{
		"text": "If you are reading this — you are the only one who found it.",
		"hold": 4.9
	},
	{
		"text": "Collect everything.\nReach the final assembler.\nFree the mango from control.",
		"hold": 5.9
	},
	{
		"text": "I am setting up a temporary server tunnel \n so you can access the fragments safely.\nYou will only see what you need at the final stage.",
		"hold": 10.2
	},
	{
		"text": "My user ID is:\n\nmilkyway (all lowercase)",
		"hold": 4.2
	},
	{
		"text": "The password will appear at the end.\nWatch carefully.",
		"hold": 2.9
	},
	{
		"text": "We don’t have much time.",
		"hold": 4.9
	}
]


func _ready():
	label.text = ""
	run_intro()


func run_intro() -> void:
	for block in messages:
		label.text = block["text"]
		await get_tree().create_timer(block["hold"]).timeout

		label.text = ""
		await get_tree().create_timer(CLEAR_GAP).timeout

	# load game
	print("[INTRO] Finished — loading next scene")
	get_tree().change_scene_to_file(next_scene)
