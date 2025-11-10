extends Button

@export var normal_texture: Texture2D
@export var pressed_texture: Texture2D
@export var hover_texture: Texture2D
@export var scene_to_load: PackedScene
@export var nodo_a_mostrar: NodePath
@export var transicion : TextureRect

@onready var icono = $TextureRect

# --- imágenes de transición del ascensor ---
var imagenes := [
	preload("res://assets/fondos-escenas/transiciones/03.png"),
	preload("res://assets/fondos-escenas/transiciones/04.png"),
	preload("res://assets/fondos-escenas/transiciones/05.png"),
	preload("res://assets/fondos-escenas/transiciones/06.png"),
	preload("res://assets/fondos-escenas/transiciones/07.png"),
	preload("res://assets/fondos-escenas/transiciones/08.png"),
	preload("res://assets/fondos-escenas/transiciones/09.png")
]

func _ready():
	if normal_texture:
		icono.texture = normal_texture

	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))


func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if pressed_texture:
				icono.texture = pressed_texture
		else:
			if normal_texture:
				icono.texture = normal_texture
				_accion_boton()


func _accion_boton():
	SoundManager.reproducir_efecto(2)
	var node = name

	if scene_to_load:
		if node == "btn_ascensorbaja":
			await _iniciar_transicion_ascensor()
		else:
			print("[Botón] Cargando escena asignada sin transición...")
			get_tree().change_scene_to_packed(scene_to_load)

	elif nodo_a_mostrar:
		var nodo = get_node_or_null(nodo_a_mostrar)
		if nodo:
			print("[Botón] Mostrando nodo asignado:", nodo.name)
			nodo.visible = true
			if nodo.name == "fondo1":
				get_parent().visible = false
		else:
			push_warning("[Botón] No se encontró el nodo en el path asignado.")
	else:
		print("[Botón] No hay acción asignada.")


func _iniciar_transicion_ascensor():
	if not transicion:
		push_warning("[Ascensor] No se encontró el nodo TransicionAscensor.")
		return
	transicion.visible = true
	SoundManager.reproducir_efecto(7)
	GameManager.texto_label = "Quizás haya algo más abajo"
	for i in imagenes.size():
		transicion.texture = imagenes[i]
		await get_tree().create_timer(0.3).timeout

	print("[Ascensor] Transición completada, cargando escena...")
	get_tree().change_scene_to_packed(scene_to_load)


func _on_mouse_entered():
	if hover_texture:
		icono.texture = hover_texture

func _on_mouse_exited():
	if normal_texture:
		icono.texture = normal_texture
