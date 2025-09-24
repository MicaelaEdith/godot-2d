extends Control

const GRID_SIZE = 5

var tiles = []
var empty_index = -1

func _ready():
	print("=== Puzzle inicializando ===")

	tiles = get_children()
	print("Tiles detectados:", tiles.size())

	for i in range(tiles.size()):
		var t = tiles[i]
		# Intentar conectar
		var ok = false
		if not t.is_connected("gui_input", self, "_on_tile_input"):
			var err = t.connect("gui_input", self, "_on_tile_input", [t])
			if err == OK:
				ok = true
		print("Tile agregado:", t.name, "pos:", t.rect_position, " conectado:", ok)

	# Buscar vacía
	for i in range(tiles.size()):
		if tiles[i].es_vacia:
			empty_index = i
			print("Ficha vacía en índice:", i)
			break

# ========================
# Helpers
# ========================
func index_to_grid(index: int) -> Vector2:
	var row = index / GRID_SIZE  # truncado
	var col = index % GRID_SIZE
	return Vector2(col, row)

func grid_to_index(grid_pos: Vector2) -> int:
	return int(grid_pos.y) * GRID_SIZE + int(grid_pos.x)

func is_adjacent(idx1: int, idx2: int) -> bool:
	var g1 = index_to_grid(idx1)
	var g2 = index_to_grid(idx2)
	return (abs(g1.x - g2.x) + abs(g1.y - g2.y)) == 1


# ========================
# Input de fichas
# ========================
func _on_tile_input(event: InputEvent, tile):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var tile_index = tiles.find(tile)
		if tile_index == -1:
			return

		print("Click en:", tile.name, "idx:", tile_index, "empty:", empty_index)

		if is_adjacent(tile_index, empty_index):
			swap_tiles(tile_index, empty_index)
		else:
			print("No es adyacente")


# ========================
# Swap
# ========================
func swap_tiles(tile_index: int, empty_idx: int):
	var tile_node = tiles[tile_index]
	var empty_node = tiles[empty_idx]

	# Intercambiar posiciones visuales
	var temp_pos = tile_node.rect_position
	tile_node.rect_position = empty_node.rect_position
	empty_node.rect_position = temp_pos

	# Intercambiar en el array
	tiles[tile_index] = empty_node
	tiles[empty_idx] = tile_node

	# Actualizar índice vacío
	empty_index = tile_index

	print("Swap:", tile_node.name, "<=>", empty_node.name, "Nuevo empty:", empty_index)
