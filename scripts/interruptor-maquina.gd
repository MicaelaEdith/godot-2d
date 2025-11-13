extends Node

@export var img_interruptor : TextureRect
@export var boton: Button
@onready var inventario = get_tree().get_root().find_child("inventario", true, false)

func _ready() -> void:
	if GameManager.interruptor_conectado:
		img_interruptor.visible = true
	else:
		img_interruptor.visible = false

	if boton:
		boton.connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed() -> void:
	if GameManager.maquina_encendida:
		return

	if GameManager.objeto_seleccionado == "interruptor.png" :
		GameManager.interruptor_conectado = true
		img_interruptor.visible = true
		if inventario:
			inventario.quitar_objeto("interruptor.png")

 
