extends Node2D

@onready var cpu_label: Label  = $CpuLabel
@onready var ram_label: Label  = $RamLabel
@onready var temp_label: Label = $TempLabel
@onready var net_label: Label  = $NetLabel

var cpu  := 75
var ram  := 42
var temp := 80
var net  := 60


func _ready():
	randomize()
	update_stats()

func update_stats():
	while true:
		cpu  = fluctuate(cpu,  50, 95)
		ram  = fluctuate(ram,  20, 80)
		temp = fluctuate(temp, 60, 95)
		net  = fluctuate(net,  30, 90)

		cpu_label.text  = format_stat("CPU",  cpu,  "%")
		ram_label.text  = format_stat("RAM",  ram,  "%")
		temp_label.text = format_stat("TEMP", temp, "°C")
		net_label.text  = format_stat("NET",  net,  "%")
		

		await get_tree().create_timer(0.9).timeout



func fluctuate(value: int, min_val: int, max_val: int) -> int:
	value += randi_range(-2, 2)
	return clamp(value, min_val, max_val)

func format_stat(name: String, value: int, suffix: String) -> String:
	var bars = int(value / 10)
	var bar_text = "▓".repeat(bars) + "░".repeat(10 - bars)
	return "%s  %s %d%s" % [name, bar_text, value, suffix]
