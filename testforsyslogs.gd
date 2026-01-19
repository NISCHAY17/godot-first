extends Label

const TOTAL_COINS  := 67
const TOTAL_FRUITS := 12

func _ready():
	text = ""
	start_validation()


func start_validation():
	await print_line("SYSTEM INITIALIZING...")
	await print_line("CONNECTING TO FRAGMENT DATABASE...")
	await print_line("STARTING COIN VERIFICATION...")

	
	for i in range(1, TOTAL_COINS + 1):
		text = "CHECKING COINS: %d / %d" % [i, TOTAL_COINS]
		await get_tree().create_timer(0.03).timeout

	await print_line("COIN CHECK PASSED")
	await print_line("STARTING FRUIT VERIFICATION...")


	for i in range(1, TOTAL_FRUITS + 1):
		text = "CHECKING FRUITS: %d / %d" % [i, TOTAL_FRUITS]
		await get_tree().create_timer(0.12).timeout

	await print_line("FRUIT CHECK PASSED")
	await print_line("ALL SYSTEMS VERIFIED")
	await print_line("UPLOAD AUTHORIZED")


func print_line(line: String):
	text = line
	await get_tree().create_timer(0.6).timeout
