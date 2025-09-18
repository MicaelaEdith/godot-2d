extends Control

const GRID_SIZE = 5
var tiles = []
var empty_pos = Vector2()
var tile_size = Vector2(192, 162)

func _ready():
	tiles = get_children()
	
	for i in range(tiles.size()):
		var t = tiles[i]
		if t is TextureRect:
			if not t.is_connected("gui_input", self, "_on_tile_input"):
				t.connect("gui_input", self, "_on_tile_input", [t])
			
			var pos = index_to_grid(i)
			t.rect_position = Vector2(pos.y * tile_size.x, pos.x * tile_size.y)
			
			if "es_vacia" in t and t.es_vacia:
				empty_pos = pos

#helpers
func index_to_grid(index: int) -> Vector2:
	var row = int(index / GRID_SIZE)
	var col = index % GRID_SIZE
	return Vector2(row, col)

func grid_to_index(pos: Vector2) -> int:
	return int(pos.x) * GRID_SIZE + int(pos.y)

func is_adjacent(pos1: Vector2, pos2: Vector2) -> bool:
	var dx = int(pos1.x) - int(pos2.x)
	var dy = int(pos1.y) - int(pos2.y)
	return (abs(dx) == 1 and dy == 0) or (abs(dy) == 1 and dx == 0)

#evento clic ficha
func _on_tile_input(event, tile_node):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var index = tiles.find(tile_node)
		if index == -1:
			return
		var clicked_pos = index_to_grid(index)
		
		if is_adjacent(clicked_pos, empty_pos):
			swap_tiles(clicked_pos, empty_pos)

#intercambiar posiciones
func swap_tiles(tile_pos: Vector2, empty: Vector2):
	var tile_index = grid_to_index(tile_pos)
	var empty_index = grid_to_index(empty)
	
	var tile_node = tiles[tile_index]
	var empty_node = tiles[empty_index]
	
	#intercambio array
	tiles[tile_index] = empty_node
	tiles[empty_index] = tile_node
	
	#actualizar posiciones físicas
	tile_node.rect_position = Vector2(empty.y * tile_size.x, empty.x * tile_size.y)
	empty_node.rect_position = Vector2(tile_pos.y * tile_size.x, tile_pos.x * tile_size.y)
	
	empty_pos = tile_pos
