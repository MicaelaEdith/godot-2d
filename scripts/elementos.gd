extends TextureRect

@export var icono_inventario: Texture2D
@onready var inventario = get_tree().get_root().find_child("inventario", true, false)

func _ready():
	if icono_inventario == null:
		return

	var path = icono_inventario.resource_path
	var recolectados = GameManager.obtener_inventario_registrado()

	
	if path in recolectados:
		visible = false
	else:
		connect("gui_input", Callable(self, "_on_gui_input"))

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SoundManager.reproducir_efecto(2)
		
		if inventario:
			inventario.agregar_objeto(icono_inventario)
		else:
			GameManager.agregar_objeto(icono_inventario)
		
		visible = false
