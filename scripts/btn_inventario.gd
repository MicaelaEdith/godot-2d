extends Button

export(Texture) var normal_texture
export(Texture) var hover_texture

onready var icono = $TextureRect

func _ready():
	if normal_texture:
		icono.texture = normal_texture

	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	if hover_texture:
		icono.texture = hover_texture

func _on_mouse_exited():
	if normal_texture:
		icono.texture = normal_texture
