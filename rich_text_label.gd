extends RichTextLabel

const TOTAL_COINS  := 67
const TOTAL_FRUITS := 12

func _ready():
	bbcode_enabled = true
	clear()
	start_validation()


func start_validation():
	await print_line("[SYS] Initializing validation protocol...")
	await print_line("[SYS] Connecting to fragment database...")
	await print_line("[SYS] Starting coin verification...")

	
	for i in range(1, TOTAL_COINS + 1):
		text = ""   
		append_text("[CHECK] Coins verified: %d / %d\n" % [i, TOTAL_COINS])
		await get_tree().create_timer(0.03).timeout

	await print_line("[OK] Coin requirement satisfied ✅")
	await print_line("[SYS] Starting fruit verification...")

	
	for i in range(1, TOTAL_FRUITS + 1):
		text = ""
		append_text("[CHECK] Fruits verified: %d / %d\n" % [i, TOTAL_FRUITS])
		await get_tree().create_timer(0.12).timeout

	await print_line("[OK] Fruit integrity verified ✅")
	await print_line("[SYS] All validation checks passed")
	await print_line("[SYS] Upload authorized")



func print_line(line: String):
	append_text(line + "\n")
	scroll_to_line(get_line_count())
	await get_tree().create_timer(0.6).timeout
