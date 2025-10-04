extends TextureRect

@export var norte: bool
@export var sur: bool
@export var este: bool
@export var oeste: bool
@export var es_vacia: bool = false

var conectado: bool = false  # variable normal

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP
	actualizar_opacidad() 
	
func set_conectado(value: bool):
	conectado = value
	actualizar_opacidad()

func actualizar_opacidad():
	if conectado:
		modulate.a = 1.0
	else:
		modulate.a = 0.65
