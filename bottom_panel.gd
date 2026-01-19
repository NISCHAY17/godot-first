extends Node2D


@onready var start_btn: Button = $Button
@onready var progress: ProgressBar = $ProgressBar

var uploading := false

func _ready():
	progress.visible = false
	progress.value = 0
	start_btn.pressed.connect(start_upload)

func start_upload():
	if uploading:
		return

	print("[SERVER] Upload started")

	uploading = true

	# 👇 Hide button
	start_btn.visible = false

	# 👇 Show progress bar
	progress.visible = true
	progress.value = 0

	run_upload()

# ----------------------------

func run_upload():
	for i in range(101):
		progress.value = i
		await get_tree().create_timer(0.04).timeout

	print("[SERVER] Upload finished")
	uploading = false
