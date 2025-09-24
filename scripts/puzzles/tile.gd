extends TextureRect

export(bool) var norte
export(bool) var sur
export(bool) var este
export(bool) var oeste
export(bool) var es_vacia = false

var conectado = false

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP  # permite que reciba clicks
