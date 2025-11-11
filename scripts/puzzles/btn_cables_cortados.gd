extends Node

@export var fondo : TextureRect
@export var nueva_imagen : Texture2D
@onready var inventario = get_tree().get_root().find_child("inventario", true, false)

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
				_accion_boton()

func _accion_boton():
	if GameManager.cables_cortados and GameManager.objeto_seleccionado == "cinta.png":
		fondo.texture = nueva_imagen
		GameManager.cables_cortados = false
		if inventario:
			inventario.quitar_objeto("cinta.png")
	
	else:
		if GameManager.cables_cortados:
			SoundManager.reproducir_efecto(2)
			if GameManager.objeto_seleccionado != null and GameManager.objeto_seleccionado != "cinta.png":
				GameManager.texto_label = "No me sirve para esto"
			else:	
				GameManager.texto_label = "Parece que alguien cortó los cables"
		
