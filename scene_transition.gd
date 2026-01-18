extends CanvasLayer

@onready var fade_rect = $ColorRect
var busy := false

func fade_to_scene(scene_path: String, duration := 1.2):
	if busy:
		return
	busy = true

	fade_rect.visible = true
	fade_rect.modulate.a = 0.0

	var t = create_tween()
	t.tween_property(fade_rect, "modulate:a", 1.0, duration)
	await t.finished

	get_tree().change_scene_to_file(scene_path)
