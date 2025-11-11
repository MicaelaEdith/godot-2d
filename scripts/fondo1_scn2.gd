extends Node

@export var fondo1 : Texture2D
@export var fondo2 : Texture2D

func _ready() -> void:
	if GameManager.cables_cortados:
		self.texture = fondo1
	else:
		self.texture = fondo2
