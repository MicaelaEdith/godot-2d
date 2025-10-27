extends Button

@export var normal_texture: Texture2D
@export var pressed_texture: Texture2D
@export var hover_texture: Texture2D
@export var scene_to_load: PackedScene
@export var nodo_a_mostrar: NodePath

@onready var icono = $TextureRect

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
	if scene_to_load:
		print("[Botón] Cargando escena asignada...")
		get_tree().change_scene_to_packed(scene_to_load)
	elif nodo_a_mostrar:
		var nodo = get_node_or_null(nodo_a_mostrar)
		if nodo:
			print("[Botón] Mostrando nodo asignado:", nodo.name)
			nodo.visible = true
		else:
			push_warning("[Botón] No se encontró el nodo en el path asignado.")
	else:
		print("[Botón] No hay acción asignada.")


func _on_mouse_entered():
	if hover_texture:
		icono.texture = hover_texture

func _on_mouse_exited():
	if normal_texture:
		icono.texture = normal_texture
