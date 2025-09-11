extends TextureRect

export(String, "horizontal","vertical","codo","codo2","tipo_t") var tile_type = "horizontal"

export(bool) var n = false
export(bool) var s = false
export(bool) var e = false
export(bool) var o = false

export(bool) var conectado = false

export(Texture) var horizontal_texture
export(Texture) var vertical_texture
export(Texture) var codo_texture
export(Texture) var codo2_texture
export(Texture) var tipo_t_texture

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

