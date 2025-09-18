extends TextureRect

export(bool) var norte
export(bool) var sur
export(bool) var este
export(bool) var oeste

var conectado = false
export(bool) var es_vacia = false


func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		_on_tile_clicked()

func _on_tile_clicked():
	if es_vacia:
		print("Tile vacía clickeada:", name)
	else:
		print("Tile clickeada:", name, "| N:", norte, " S:", sur, " E:", este, " O:", oeste)
