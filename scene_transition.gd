extends CanvasLayer

@onready var rect: ColorRect = $ColorRect
var busy := false

func fade_to(scene_path: String, duration := 1.0):
	if busy:
		return
	busy = true

	rect.visible = true
	rect.modulate.a = 0.0

	var t = create_tween()
	t.tween_property(rect, "modulate:a", 1.0, duration)
	await t.finished

	get_tree().change_scene_to_file(scene_path)

	# Fade in 
	await get_tree().process_frame
	rect.modulate.a = 1.0

	var t2 = create_tween()
	t2.tween_property(rect, "modulate:a", 0.0, duration)
	await t2.finished

	rect.visible = false
	busy = false
