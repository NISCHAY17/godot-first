extends TileMap


var collected := 0

@export var player_path: NodePath
@onready var player = get_node(player_path)


func _process(delta):
	check_player_tile()


func check_player_tile():
	if player == null:
		return

	# Convert player world position to tile cell
	var cell = local_to_map(to_local(player.global_position))

	# Get tile at that cell (layer 0)
	var tile_id = get_cell_source_id(0, cell)

	# If tile exists → collect it
	if tile_id != -1:
		erase_cell(0, cell)
		collected += 1
		print("Collected:", collected)
