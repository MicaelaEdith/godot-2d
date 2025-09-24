extends TextureRect

export(Texture) var icono_inventario
onready var inventario = get_node("/root/Capitulo1/inventario") 

func _ready():
	connect("gui_input", self, "_on_gui_input")

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		inventario.agregar_objeto(icono_inventario)
		visible = false
