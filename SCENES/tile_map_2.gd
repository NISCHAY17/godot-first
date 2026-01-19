extends TileMap

@export var player_path: NodePath
@onready var player = get_node(player_path)

var last_cell := Vector2i(-999, -999)

func _process(delta):
	check_player_tile()

func check_player_tile():
	if player == null:
		return

	var cell: Vector2i = local_to_map(to_local(player.global_position))

	if cell == last_cell:
		return

	last_cell = cell

	var tile_id = get_cell_source_id(0, cell)

	if tile_id != -1:
		erase_cell(0, cell)

		# Send fruit 
		Gamemanager.add_fruit(str(cell))
