extends TextureRect

@export var icono_inventario: Texture2D
@onready var inventario = get_node("/root/Capitulo1/inventario")

func _ready():
	if icono_inventario == null:
		return
	
	var path = icono_inventario.resource_path
	var recolectados = GameManager.obtener_recolectados()
	
	if path in recolectados:
		visible = false
	else:
		connect("gui_input", Callable(self, "_on_gui_input"))

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		inventario.agregar_objeto(icono_inventario)
		visible = false
