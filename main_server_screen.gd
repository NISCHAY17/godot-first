extends Node2D

@onready var start_btn: Button = $BottomPanel/Button
@onready var progress: ProgressBar =$BottomPanel/ProgressBar
@onready var log_label: Label = $RightPanel/Label
@onready var clciksfx: AudioStreamPlayer = $clciksfx



@export var TEST_MODE := true

@export var REQUIRED_COINS := 67
@export var REQUIRED_FRUITS := 12

@export var TEST_COINS := 67
@export var TEST_FRUITS := 12

@export var SPEED_COINS := 0.08
@export var SPEED_FRUITS := 0.15



var running := false

func _ready():
	log_label.text = "WAITING FOR INPUT..."
	progress.visible = false
	progress.value = 0
	start_btn.pressed.connect(start_stream)
	clciksfx.play()



func start_stream():
	if running:
		return

	running = true

	start_btn.visible = false
	progress.visible = true
	progress.value = 0

	var coins_actual  = TEST_COINS  if TEST_MODE else Gamemanager.score
	var fruits_actual = TEST_FRUITS if TEST_MODE else Gamemanager.total_fruits

	print("[SERVER] Actual → Coins:", coins_actual, " Fruits:", fruits_actual)

	await run_coin_check(coins_actual, fruits_actual)



func run_coin_check(coins_actual: int, fruits_actual: int):
	
	var scan_target = min(coins_actual, REQUIRED_COINS)

	for i in range(1, scan_target + 1):
		var percent = int(float(i) / REQUIRED_COINS * 50.0)
		progress.value = percent
		log_label.text = "CHECKING COINS: %d / %d" % [i, REQUIRED_COINS]
		await get_tree().create_timer(SPEED_COINS).timeout

	
	if coins_actual < REQUIRED_COINS:
		log_label.text = "ERROR: INSUFFICIENT COINS (%d / %d)" % [coins_actual, REQUIRED_COINS]
		print("[SERVER] ❌ Coin validation failed")
		await get_tree().create_timer(2.0).timeout
		reset_system()
		return

	
	await run_fruit_check(fruits_actual)



func run_fruit_check(fruits_actual: int):
	var scan_target = min(fruits_actual, REQUIRED_FRUITS)

	for i in range(1, scan_target + 1):
		var percent = 50 + int(float(i) / REQUIRED_FRUITS * 50.0)
		progress.value = percent
		log_label.text = "CHECKING FRUITS: %d / %d" % [i, REQUIRED_FRUITS]
		await get_tree().create_timer(SPEED_FRUITS).timeout

	
	if fruits_actual < REQUIRED_FRUITS:
		log_label.text = "ERROR: INSUFFICIENT FRUITS (%d / %d)" % [fruits_actual, REQUIRED_FRUITS]
		print("[SERVER] ❌ Fruit validation failed")
		await get_tree().create_timer(2.0).timeout
		reset_system()
		return

	
	progress.value = 100
	log_label.text = "UPLOAD AUTHORIZED ✅"
	print("[SERVER] ✅ Validation complete")



func reset_system():
	print("[SERVER] Resetting system")
	running = false
	start_btn.visible = true
	progress.visible = false
	progress.value = 0
	log_label.text = "WAITING FOR INPUT..."
