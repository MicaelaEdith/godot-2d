extends Button

export(Texture) var normal_texture
export(Texture) var pressed_texture
export(PackedScene) var scene_to_load 

onready var icono = $TextureRect

func _ready():
	if normal_texture:
		icono.texture = normal_texture

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
