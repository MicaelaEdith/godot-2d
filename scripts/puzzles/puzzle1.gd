extends Control 

export(Vector2) var cell_size = Vector2(100,100)
export(PackedScene) var tile_scene

const ROWS = 5
const COLS = 5

var grid = []
var tiles = {}
var empty_pos = Vector2()

func _ready():
	_init_grid()
	_create_tiles()

func _init_grid():
	grid = []
	var count = 1
	for r in range(ROWS):
		var row = []
		for c in range(COLS):
			if r == ROWS-1 and c == COLS-1:
				row.append(0)
				empty_pos = Vector2(c,r)
			else:
				row.append(count)
				count += 1
		grid.append(row)

func _create_tiles():
	for r in range(ROWS):
		for c in range(COLS):
			var id = grid[r][c]
			if id == 0:
				continue
			var tile = tile_scene.instance()
			tile.rect_position = Vector2(c,r) * cell_size
			# Propiedades extra
			tile.nseo = Vector4(false,false,false,false)
			tile.conectado = false
			tile.connect("gui_input", self, "_on_tile_input", [r,c])
			add_child(tile)
			tiles[id] = tile

# Manejo de click en ficha
func _on_tile_input(event, r, c):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if _is_adjacent(Vector2(c,r), empty_pos):
			_move_tile(Vector2(c,r))

# Verifica si la ficha está adyacente al espacio vacío
func _is_adjacent(pos, empty):
	return abs(pos.x - empty.x) + abs(pos.y - empty.y) == 1

# Intercambia ficha con el vacío
func _move_tile(pos):
	var id = grid[pos.y][pos.x]
	# Actualiza grilla lógica
	grid[empty_pos.y][empty_pos.x] = id
	grid[pos.y][pos.x] = 0
	# Actualiza posición física
	tiles[id].rect_position = empty_pos * cell_size
	empty_pos = pos
