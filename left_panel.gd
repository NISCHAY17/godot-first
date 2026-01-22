extends Node2D

@onready var cpu_label: Label  = $CpuLabel
@onready var ram_label: Label  = $RamLabel
@onready var temp_label: Label = $TempLabel
@onready var net_label: Label  = $NetLabel

var cpu  := 70
var ram  := 50
var temp := 65
var net  := 55

# idle / scanning / danger / success
var mode := "idle"


func _ready():
	randomize()
	update_stats()


func update_stats():
	while true:

		match mode:
			"idle":
				cpu  = fluctuate(cpu,  40, 70)
				ram  = fluctuate(ram,  30, 60)
				temp = fluctuate(temp, 45, 70)
				net  = fluctuate(net,  30, 55)
				set_color(Color.WHITE)

			"scanning":
				cpu  = fluctuate(cpu,  75, 90)
				ram  = fluctuate(ram,  60, 85)
				temp = fluctuate(temp, 75, 88)
				net  = fluctuate(net,  65, 90)
				set_color(Color.YELLOW)

			"danger":
				cpu  = fluctuate(cpu,  92, 100)
				ram  = fluctuate(ram,  92, 100)
				temp = fluctuate(temp, 92, 100)
				net  = fluctuate(net,  92, 100)
				set_color(Color.RED)

			"success":
				cpu  = fluctuate(cpu,  55, 70)
				ram  = fluctuate(ram,  40, 60)
				temp = fluctuate(temp, 50, 65)
				net  = fluctuate(net,  40, 60)
				set_color(Color.LIME_GREEN)

		cpu_label.text  = format_stat("CPU",  cpu,  "%")
		ram_label.text  = format_stat("RAM",  ram,  "%")
		temp_label.text = format_stat("TEMP", temp, "°C")
		net_label.text  = format_stat("NET",  net,  "%")

		await get_tree().create_timer(0.7).timeout


func set_color(c: Color):
	cpu_label.modulate  = c
	ram_label.modulate  = c
	temp_label.modulate = c
	net_label.modulate  = c


func fluctuate(value: int, min_val: int, max_val: int) -> int:
	value += randi_range(-2, 2)
	return clamp(value, min_val, max_val)


func format_stat(name: String, value: int, suffix: String) -> String:
	var bars = int(value / 10)
	var bar_text = "▓".repeat(bars) + "░".repeat(10 - bars)
	return "%s  %s %d%s" % [name, bar_text, value, suffix]
