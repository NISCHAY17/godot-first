extends Node2D

@onready var start_btn: Button = $BottomPanel/Button
@onready var progress: ProgressBar = $BottomPanel/ProgressBar
@onready var log_label: Label = $RightPanel/Label
@onready var click_sfx: AudioStreamPlayer = $clciksfx
@onready var alarm_sfx: AudioStreamPlayer = $AlarmSirenSoundEffectType01294194
@onready var server_panel = $LeftPanel 
@export var fail_scene := "res://SCENES/fail.tscn"
@export var win_scene  := "res://SCENES/success.tscn"

@export var TEST_MODE := true

@export var REQUIRED_COINS := 67
@export var REQUIRED_FRUITS := 12
@export var REQUIRED_KEYS := 1

@export var TEST_COINS := 67
@export var TEST_FRUITS := 12
@export var TEST_KEYS := 1

@export var SPEED_COINS := 0.08
@export var SPEED_FRUITS := 0.15

var running := false


func _ready():
	log_label.text = "WAITING FOR INPUT..."
	progress.visible = false
	progress.value = 0
	start_btn.pressed.connect(start_stream)


func start_stream():
	if running:
		return

	running = true
	click_sfx.play()

	start_btn.visible = false
	progress.visible = true
	progress.value = 0

	server_panel.mode = "scanning"

	var coins_actual  = TEST_COINS  if TEST_MODE else Gamemanager.score
	var fruits_actual = TEST_FRUITS if TEST_MODE else Gamemanager.total_fruits
	var keys_actual   = TEST_KEYS   if TEST_MODE else Gamemanager.keys

	print("[SERVER] Actual → Coins:", coins_actual, "Fruits:", fruits_actual, "Keys:", keys_actual)

	await run_coin_check(coins_actual, fruits_actual, keys_actual)



func run_coin_check(coins_actual: int, fruits_actual: int, keys_actual: int):
	var scan_target = min(coins_actual, REQUIRED_COINS)

	for i in range(1, scan_target + 1):
		var percent = int(float(i) / REQUIRED_COINS * 40.0)
		progress.value = percent
		log_label.text = "CHECKING COINS: %d / %d" % [i, REQUIRED_COINS]
		await get_tree().create_timer(SPEED_COINS).timeout

	if coins_actual < REQUIRED_COINS:
		fail("INSUFFICIENT COINS")
		return

	await run_fruit_check(fruits_actual, keys_actual)


# ---------------- FRUITS ----------------
func run_fruit_check(fruits_actual: int, keys_actual: int):
	var scan_target = min(fruits_actual, REQUIRED_FRUITS)

	for i in range(1, scan_target + 1):
		var percent = 40 + int(float(i) / REQUIRED_FRUITS * 40.0)
		progress.value = percent
		log_label.text = "CHECKING FRUITS: %d / %d" % [i, REQUIRED_FRUITS]
		await get_tree().create_timer(SPEED_FRUITS).timeout

	if fruits_actual < REQUIRED_FRUITS:
		fail("INSUFFICIENT FRUITS")
		return

	await run_key_check(keys_actual)
	
func run_key_check(keys_actual: int):
	log_label.text = "VERIFYING SECURITY KEY..."
	await get_tree().create_timer(1.0).timeout

	if keys_actual < REQUIRED_KEYS:
		fail("SECURITY KEY NOT FOUND")
		return

	success()



func fail(reason: String):
	print("[SERVER] ❌", reason)
	log_label.text = "ERROR: " + reason

	server_panel.mode = "danger"
	alarm_sfx.play()

	await get_tree().create_timer(7.0).timeout
	get_tree().change_scene_to_file(fail_scene)



func success():
	print("[SERVER] ✅ VALIDATION COMPLETE")
	log_label.text = "UPLOAD AUTHORIZED"

	progress.value = 100
	server_panel.mode = "success"

	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file(win_scene)
