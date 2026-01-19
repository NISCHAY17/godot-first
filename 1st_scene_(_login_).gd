extends Node2D

@onready var user_field: LineEdit = $UserField
@onready var pass_field: LineEdit = $PassField
@onready var status: Label = $Status
@onready var submit_btn: Button = $Button
@onready var loading: Node2D = %LOADING
@onready var main_welcome_: Node2D = $"../MAIN(WELCOME)"
@onready var main: Node2D = $"../MAIN"

const CORRECT_USER = "MILKYWAY"
const CORRECT_PASS = "OVERGLADE"

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

		await transition_to_main()

	else:
		status.text = "> ACCESS DENIED"
		status.modulate = Color.RED
		print("[LOGIN] ❌ Access denied")


func transition_to_main():
	#  login
	visible = false

	#  loading
	loading.visible = true

	#  delay
	await get_tree().create_timer(5.0).timeout

	# Hide loading
	loading.visible = false
	main_welcome_.visible = true
	await get_tree().create_timer(7.0).timeout
	main_welcome_.visible = false
	main.visible = true 
