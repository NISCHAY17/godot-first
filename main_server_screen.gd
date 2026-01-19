extends Node2D

@onready var start_btn: Button   = $BottomPanel/Button
@onready var progress: ProgressBar = $BottomPanel/ProgressBar
@onready var log_label: Label    = $RightPanel/Label

const TOTAL_COINS  := 67
const TOTAL_FRUITS := 12

var running := false

func _ready():
	log_label.text = "WAITING FOR INPUT..."
	progress.visible = false
	progress.value = 0
	start_btn.pressed.connect(start_stream)



func start_stream():
	if running:
		return

	print("[SERVER] Data stream started")

	running = true


	start_btn.visible = false
	progress.visible = true
	progress.value = 0

	run_data_stream()



func run_data_stream():
	
	for i in range(1, TOTAL_COINS + 1):
		var percent = int(float(i) / TOTAL_COINS * 50.0)   
		progress.value = percent

		log_label.text = "CHECKING COINS: %d / %d" % [i, TOTAL_COINS]

		await get_tree().create_timer(0.04).timeout

	
	for i in range(1, TOTAL_FRUITS + 1):
		var percent = 50 + int(float(i) / TOTAL_FRUITS * 50.0)  
		progress.value = percent

		log_label.text = "CHECKING FRUITS: %d / %d" % [i, TOTAL_FRUITS]

		await get_tree().create_timer(0.12).timeout


	progress.value = 100
	log_label.text = "UPLOAD AUTHORIZED ✅"
	print("[SERVER] Validation complete")
