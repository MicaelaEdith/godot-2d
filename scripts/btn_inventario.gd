extends Button

@export var normal_texture: Texture2D
@export var hover_texture: Texture2D

@onready var fondo = $Fondo   
@onready var icono = $Icono 

func _ready():
	if normal_texture:
		fondo.texture = normal_texture

	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	if hover_texture:
		fondo.texture = hover_texture

func _on_mouse_exited():
	if normal_texture:
		fondo.texture = normal_texture

func set_icon(texture: Texture2D):
	icono.texture = texture

func clear_icon():
	icono.texture = null
