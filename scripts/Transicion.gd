extends Node2D

@onready var imagen := $imagen
@onready var fade_rect := ColorRect.new()

var transiciones_imagenes := [
	[
		preload("res://assets/fondos-escenas/transiciones/00.png"),
		preload("res://assets/fondos-escenas/transiciones/01.png"),
		preload("res://assets/fondos-escenas/transiciones/02.png")
	], 
]

var escenas_destino := [
	"res://Capitulo1.tscn",
	"res://Capitulo2.tscn"
]

var indice_imagen := 0
var actual_lista := []
var escena_destino := ""

func _ready():
	fade_rect.color = Color.BLACK
	fade_rect.size = get_viewport_rect().size
	fade_rect.visible = false
	fade_rect.modulate.a = 0.0
	add_child(fade_rect)

	var indice_transicion = clamp(GameManager.transicion, 0, transiciones_imagenes.size() - 1)
	actual_lista = transiciones_imagenes[indice_transicion]
	escena_destino = escenas_destino[indice_transicion]

	if actual_lista.is_empty():
		print("No hay imágenes para la transición", indice_transicion)
		_cargar_siguiente_escena()
		return

	imagen.texture = actual_lista[0]
	print("[Transiciones] Mostrando transición", indice_transicion, "con", actual_lista.size(), "imágenes")

func _input(event):
	if event.is_action_pressed("ui_accept") or event is InputEventMouseButton and event.pressed:
		_mostrar_siguiente()

func _mostrar_siguiente():
	indice_imagen += 1
	if indice_imagen < actual_lista.size():
		imagen.texture = actual_lista[indice_imagen]
	else:
		_iniciar_fade_out()

func _iniciar_fade_out():
	print("[Transiciones] Iniciando fade out...")
	fade_rect.visible = true
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 2.0)
	SoundManager.fade_out_tiempo(2.0) 
	tween.finished.connect(_cargar_siguiente_escena)

func _cargar_siguiente_escena():
	print("[Transiciones] Transición completada, cargando:", escena_destino)
	GameManager.transicion += 1
	get_tree().change_scene_to_file(escena_destino)
