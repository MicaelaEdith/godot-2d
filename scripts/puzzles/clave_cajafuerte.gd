extends TextureRect

@export var img_fondo_escena : TextureRect
@export var img_fondo_estante : TextureRect
@export var piedra : TextureRect

@onready var botones = [
	$btn1,
	$btn2,
	$btn3
]

var simbolos = [
	preload("res://assets/fondos-escenas/piezas/simbolos/b1.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/b2.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/b3.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/b4.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/b5.png"),
]

var nuevo_fondo = preload("res://assets/fondos-escenas/scn2_b2.png")
var nuevo_estante = preload("res://assets/fondos-escenas/estante_b.png")

var indices = [3, 4, 1]
var codigo_correcto = [0, 3, 4]

func _ready():
	for i in range(botones.size()):
		botones[i].connect("pressed", Callable(self, "_on_boton_pressed").bind(i))
		_actualizar_boton(i)

func _on_boton_pressed(i: int):
	SoundManager.reproducir_efecto(2)
	indices[i] = (indices[i] + 1) % simbolos.size()
	_actualizar_boton(i)
	_verificar_codigo()

func _actualizar_boton(i: int):
	var boton = botones[i]
	if boton.has_node("textura"):
		boton.get_node("textura").texture = simbolos[indices[i]]
	else:
		if boton is TextureButton:
			boton.texture_normal = simbolos[indices[i]]
		else:
			boton.icon = simbolos[indices[i]]

func _verificar_codigo():
	if indices == codigo_correcto:
		_resolver_puzzle()

func _resolver_puzzle():
	print("[Puzzle Código] resuelto")
	_cargar_nuevo_fondo()
	
func _cargar_nuevo_fondo():
	SoundManager.reproducir_efecto(8)
	img_fondo_escena.texture = nuevo_fondo
	img_fondo_estante.texture = nuevo_estante
	botones[0].visible = false
	botones[1].visible = false
	botones[2].visible = false
	piedra.visible = true
	GameManager.caja_fuerte = true
		
