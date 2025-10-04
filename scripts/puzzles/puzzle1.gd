extends Control

@onready var tiles_container: Control = $fondo/control
var grid_size: int = 5
var tiles: Array = []
var empty_tile
var empty_index: int = -1

func _ready():
	inicializar_puzzle()

func inicializar_puzzle():
	tiles.clear()
	for child in tiles_container.get_children():
		tiles.append(child)
		if child.es_vacia:
			empty_tile = child
	empty_index = tiles.find(empty_tile)
	print("Tiles detectados:%d" % tiles.size())
	print("Ficha vacía en índice:%d" % empty_index)

# --- Manejo de clicks ---
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		for tile in tiles:
			if tile.get_global_rect().has_point(get_global_mouse_position()):
				intentar_mover(tile)
				break

# --- Movimiento de fichas ---
func intentar_mover(tile):
	var tile_index = tiles.find(tile)
	if tile_index == -1:
		return

	var tile_row = tile_index / grid_size
	var tile_col = tile_index % grid_size
	var empty_row = empty_index / grid_size
	var empty_col = empty_index % grid_size

	var es_adyacente = (tile_row == empty_row and abs(tile_col - empty_col) == 1) \
					 or (tile_col == empty_col and abs(tile_row - empty_row) == 1)
	if es_adyacente:
		intercambiar(tile, tile_index)

func intercambiar(tile, tile_index):
	var pos_tile = tile.position
	var pos_empty = empty_tile.position
	tile.position = pos_empty
	empty_tile.position = pos_tile

	tiles[empty_index] = tile
	tiles[tile_index] = empty_tile
	empty_index = tile_index

	# Propagar corriente después de mover
	propagar_corriente()
	if puzzle_completo():
		print("¡Circuito completado!")

# --- Grilla helper ---
func get_tile(row: int, col: int):
	if row < 0 or row >= grid_size or col < 0 or col >= grid_size:
		return null
	return tiles[row * grid_size + col]

# --- Propagación de corriente ---
func reset_conectado():
	for tile in tiles:
		tile.set_conectado(false)

func propagar_corriente():
	reset_conectado()
	
	var start_tile = get_tile(1, 0)
	var queue: Array = []

	if start_tile.oeste:
		start_tile.set_conectado(true)
		queue.append(start_tile)
	else:
		return

	while queue.size() > 0:
		var current = queue.pop_front()
		var index = tiles.find(current)
		var row = index / grid_size
		var col = index % grid_size

		var vecino

		# Norte
		vecino = get_tile(row - 1, col)
		if vecino != null and current.norte and vecino.sur and not vecino.conectado:
			vecino.set_conectado(true)
			queue.append(vecino)
		# Sur
		vecino = get_tile(row + 1, col)
		if vecino != null and current.sur and vecino.norte and not vecino.conectado:
			vecino.set_conectado(true)
			queue.append(vecino)
		# Este
		vecino = get_tile(row, col + 1)
		if vecino != null and current.este and vecino.oeste and not vecino.conectado:
			vecino.set_conectado(true)
			queue.append(vecino)
		# Oeste
		vecino = get_tile(row, col - 1)
		if vecino != null and current.oeste and vecino.este and not vecino.conectado:
			vecino.set_conectado(true)
			queue.append(vecino)

# --- Chequeo circuito cerrado ---
func puzzle_completo() -> bool:
	var end_tile = get_tile(3, 4)  # salida
	return end_tile.conectado and end_tile.este
