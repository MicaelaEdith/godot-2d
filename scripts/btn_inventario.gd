extends Button

@export var normal_texture: Texture2D
@export var hover_texture: Texture2D
@export var press_texture: Texture2D

@onready var fondo = $Fondo
@onready var icono = $Icono

func _ready():
	toggle_mode = true
	if normal_texture:
		fondo.texture = normal_texture

	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("toggled", Callable(self, "_on_toggled"))

func _on_mouse_entered():
	if not button_pressed and hover_texture:
		fondo.texture = hover_texture

func _on_mouse_exited():
	if not button_pressed and normal_texture:
		fondo.texture = normal_texture

func _on_toggled(pressed: bool) -> void:
	if icono.texture == null:
		button_pressed = false
		if normal_texture:
			fondo.texture = normal_texture
		return

	if pressed:
		if press_texture:
			fondo.texture = press_texture
	else:
		if normal_texture:
			fondo.texture = normal_texture

func set_icon(texture: Texture2D):
	icono.texture = texture

func clear_icon():
	icono.texture = null
