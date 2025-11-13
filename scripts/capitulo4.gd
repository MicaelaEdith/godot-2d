extends Node

var texto2 = false
var flag = false
@onready var fade_rect := ColorRect.new()

@export var img_creditos1: Texture2D
@export var img_creditos2: Texture2D
@export var creditos: TextureRect

func _ready() -> void:
	GameManager.texto_label = "¡¿QUÉ PASÓ?! ¡¡¡EL LABORATORIO ESTÁ CAMBIADO!!!"

func _process(delta: float) -> void:
	SoundManager.detener_efectos()
	SoundManager.reanudar_musica()

	if not texto2 and not GameManager.texto_label == "¡¿QUÉ PASÓ?! ¡¡¡EL LABORATORIO ESTÁ CAMBIADO!!!":
		if not flag:
			GameManager.texto_label = "Así es, Segundo, viajar en el tiempo lo cambia todo, tengo mucho que contarte"
			flag = true
		texto2 = true

	if texto2 and GameManager.texto_label == "":
		texto2 = false
		_mostrar_creditos()

func _mostrar_creditos() -> void:
	await get_tree().create_timer(1.0).timeout
	creditos.visible = true

	await get_tree().create_timer(1.5).timeout
	creditos.texture = img_creditos2

	
