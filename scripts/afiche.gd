extends Node

@export var boton: Button
@export var img_pistas: TextureRect
@onready var inventario = get_tree().get_root().find_child("inventario", true, false)

func _ready():
	if boton:
		boton.connect("pressed", Callable(self, "_on_boton_pressed"))
	if img_pistas:
		img_pistas.visible = GameManager.afiche_pistas_mostradas

func _on_boton_pressed():
	if GameManager.objeto_seleccionado == "botella_i.png":
		if img_pistas:
			img_pistas.visible = true
			GameManager.afiche_pistas_mostradas = true
			print("[BotonInteractivo] Imagen mostrada (botella_i.png)")
			if inventario:
				inventario.quitar_objeto("botella_i.png")
	else:
		if GameManager.objeto_seleccionado != null:
			GameManager.texto_label = "Esto no me servirá..."

		print("[BotonInteractivo] No se cumple la condición, objeto seleccionado:", GameManager.objeto_seleccionado)
