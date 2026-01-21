extends Node2D

@onready var mango: Sprite2D = $Mango
@onready var scroll: ScrollContainer = $ScrollContainer
@onready var story: RichTextLabel = $ScrollContainer/StoryText
@onready var voice: AudioStreamPlayer = $Success

@export var SHOW_MANGO_TIME := 3.0
@export var TYPE_SPEED := 0.035

var target_scroll := 0.0


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
	mango.visible = true
	scroll.visible = false
	story.text = ""
	start_sequence()


func _process(delta):
	
	var bar := scroll.get_v_scroll_bar()
	if bar:
		bar.value = lerp(bar.value, target_scroll, delta * 10.0)


func start_sequence() -> void:
	await get_tree().create_timer(SHOW_MANGO_TIME).timeout

	# Switch to text
	mango.visible = false
	scroll.visible = true

	
	if voice:
		voice.play()
		print("[SUCCESS] Voice started")

	await type_text(STORY_TEXT)
	print("[SUCCESS] Story finished")


func type_text(text: String) -> void:
	story.text = ""

	for i in text.length():
		story.text += text[i]

		
		var bar := scroll.get_v_scroll_bar()
		if bar:
			target_scroll = bar.max_value

		await get_tree().create_timer(TYPE_SPEED).timeout
