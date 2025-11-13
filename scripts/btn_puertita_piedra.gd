extends Node

@export var img_apagado: Texture2D
@export var img_prendido: Texture2D
@export var img_elemento: TextureRect
@export var node: TextureRect
@export var boton: Button
@onready var inventario = get_tree().get_root().find_child("inventario", true, false)

func _ready() -> void:
	if not GameManager.maquina_encendida:
		node.texture = img_apagado
	else:
		img_elemento.visible = false
		node.texture = img_prendido

	if boton:
		boton.connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed() -> void:
	if GameManager.maquina_encendida:
		return

	if GameManager.objeto_seleccionado == "piedra.png":
		GameManager.maquina_encendida = true
		if inventario:
			inventario.quitar_objeto("piedra.png")
		
		SoundManager.reproducir_efecto(9)
		print("[Maquina] Máquina encendida. Iniciando secuencia visual.")
		
		await _animar_encendido()

		get_tree().change_scene_to_file("res://Transicion.tscn")
	else:
		if GameManager.objeto_seleccionado != null:
			GameManager.texto_label = "Esto no funciona"

func _animar_encendido() -> void:
	for i in range(4):
		node.texture = img_prendido
		await get_tree().create_timer(0.3).timeout
		node.texture = img_apagado
		await get_tree().create_timer(0.3).timeout

	node.texture = img_prendido
	if img_elemento:
		img_elemento.visible = false
