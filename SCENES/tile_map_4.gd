extends TileMap

@export var player_path: NodePath
@onready var player = get_node(player_path)

func _process(delta):
	check_player_tile()

func check_player_tile():
	if player == null:
		return

	var cell = local_to_map(to_local(player.global_position))
	var tile_id = get_cell_source_id(0, cell)

	if tile_id != -1:
		erase_cell(0, cell)

		#  Gamemanager
		Gamemanager.add_key()
