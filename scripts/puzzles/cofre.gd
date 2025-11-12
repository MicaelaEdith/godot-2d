extends Node

@export var img_cerrado: Texture2D
@export var img_abierto: Texture2D
@export var img_elemento: TextureRect
@export var node: TextureRect
@export var boton: Button
@onready var inventario = get_tree().get_root().find_child("inventario", true, false)

func _ready() -> void:
	if GameManager.cofre_cerrado:
		node.texture = img_cerrado
	else:
		node.texture = img_abierto
		if not GameManager.interruptor_encontrado:
			img_elemento.visible = true

	if boton:
		boton.connect("pressed", Callable(self, "_on_cofre_pressed"))

func _on_cofre_pressed() -> void:
	if GameManager.cofre_cerrado:
		SoundManager.reproducir_efecto(2)

		if GameManager.objeto_seleccionado == "llave.png":
			GameManager.cofre_cerrado = false
			node.texture = img_abierto
			print("[Cofre] Se abrió correctamente con la llave.")
			
			if inventario:
				inventario.quitar_objeto("llave.png")
			
			if img_elemento:
				img_elemento.visible = true
				
		else:
			if GameManager.objeto_seleccionado != null:
				GameManager.texto_label = "Esto no funciona"
			else:
				GameManager.texto_label = "Necesito la llave del candado"
