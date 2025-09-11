extends Button

export(Texture) var normal_texture
export(Texture) var pressed_texture
export(Texture) var hover_texture
export(PackedScene) var scene_to_load 

onready var icono = $TextureRect

func _ready():
	if normal_texture:
		icono.texture = normal_texture

	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				if pressed_texture:
					icono.texture = pressed_texture
			else:
				if normal_texture:
					icono.texture = normal_texture
					if scene_to_load:
						get_tree().change_scene_to(scene_to_load)

func _on_mouse_entered():
	if hover_texture:
		icono.texture = hover_texture

func _on_mouse_exited():
	if normal_texture:
		icono.texture = normal_texture
