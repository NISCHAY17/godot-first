extends Node2D

@onready var user_field: LineEdit = $UserField
@onready var pass_field: LineEdit = $PassField
@onready var status: Label = $Status
@onready var submit_btn: Button = $Button

# to  Change these later
const CORRECT_USER = "admin"
const CORRECT_PASS = "evilcrop"

func _ready():
	pass_field.secret = true
	status.text = "> Awaiting credentials..."
	submit_btn.pressed.connect(_on_submit_pressed)

func _on_submit_pressed():
	var user = user_field.text.strip_edges().to_lower()
	var password = pass_field.text.strip_edges().to_lower()

	print("[LOGIN] User:", user, "Pass:", password)

	if user == "" or password == "":
		status.text = "> Fields cannot be empty"
		status.modulate = Color.ORANGE
		return

	if user == CORRECT_USER and password == CORRECT_PASS:
		status.text = "> ACCESS GRANTED"
		status.modulate = Color.GREEN
		print("[LOGIN] ✅ Access granted")

		# Tell parent to switch screen
		get_parent().show_main()

	else:
		status.text = "> ACCESS DENIED"
		status.modulate = Color.RED
		print("[LOGIN] ❌ Access denied")
