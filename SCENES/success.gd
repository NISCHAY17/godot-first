extends Node2D

var mango: Sprite2D
var story_label: Label
var voice: AudioStreamPlayer

@export var SHOW_MANGO_TIME := 3.0
@export var TYPE_SPEED := 0.035

const STORY_TEXT := """
Upload complete.

Genome fragments aligned.
Encryption dissolved.
Signal broadcasted globally.

The mango genome is free.

For decades, EVIL CROP controlled food through artificial scarcity.
They patented life itself.
Every seed was tracked.
Every harvest was taxed.
Every farmer was owned.

You broke the lock.

The original genome has now been released worldwide.
Anyone can grow real mangoes again.
No licenses. No restrictions. No control.

Fields will bloom where factories once ruled.
Seeds will pass freely between hands.
Food belongs to people again.

You didn’t just win a game.
You restored a future.

The mango is free.
"""

func _ready():
	
	call_deferred("_init_nodes")

func _init_nodes():
	mango = get_node("Mango")
	story_label = get_node("STORY TEXT")
	voice = get_node("Success")

	print("[SUCCESS] mango =", mango)
	print("[SUCCESS] story_label =", story_label)
	print("[SUCCESS] voice =", voice)

	if mango == null or story_label == null or voice == null:
		push_error("One or more nodes not found. Check node names!")
		return

	start_sequence()



func start_sequence():
	mango.visible = true
	story_label.visible = false
	story_label.text = ""

	await get_tree().create_timer(SHOW_MANGO_TIME).timeout

	mango.visible = false
	story_label.visible = true

	voice.play()

	await type_text(STORY_TEXT)

	print("[SUCCESS] Story complete")



func type_text(text: String) -> void:
	story_label.text = ""

	for i in text.length():
		story_label.text += text[i]
		await get_tree().create_timer(TYPE_SPEED).timeout
