extends TextureRect

@export var tile_type = "horizontal" # (String, "horizontal","vertical","codo","codo2","tipo_t")

@export var n: bool = false
@export var s: bool = false
@export var e: bool = false
@export var o: bool = false

@export var conectado: bool = false

@export var horizontal_texture: Texture2D
@export var vertical_texture: Texture2D
@export var codo_texture: Texture2D
@export var codo2_texture: Texture2D
@export var tipo_t_texture: Texture2D

func _ready():
	match tile_type:
		"horizontal":
			n = false
			s = false
			e = true
			o = true
		"vertical":
			n = true
			s = true
			e = false
			o = false
		"codo":
			n = false
			s = true
			e = false
			o = true
		"codo2":
			n = true
			s = false
			e = true
			o = false
		"tipo_t":
			n = true
			s = true
			e = false
			o = true


func get_nseo_array():
	return [n, s, e, o]

