extends Button

@export var normal_texture: Texture2D
@export var pressed_texture: Texture2D
@export var hover_texture: Texture2D
@export var scene_to_load: PackedScene 

@onready var icono = $TextureRect

func _ready():
	if normal_texture:
		icono.texture = normal_texture

	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if pressed_texture:
					icono.texture = pressed_texture
			else:
				if normal_texture:
					icono.texture = normal_texture
					if scene_to_load:
						get_tree().change_scene_to_packed(scene_to_load)

func _on_mouse_entered():
	if hover_texture:
		icono.texture = hover_texture

func _on_mouse_exited():
	if normal_texture:
		icono.texture = normal_texture
