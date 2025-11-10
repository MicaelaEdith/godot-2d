extends TextureRect

@onready var botones = [
	$btn1,
	$btn2,
	$btn3,
	$btn4
]

var simbolos = [
	preload("res://assets/fondos-escenas/piezas/simbolos/0.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/1.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/2.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/3.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/4.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/5.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/6.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/7.png"),
	preload("res://assets/fondos-escenas/piezas/simbolos/8.png"),
]

var indices = [3, 2, 1, 0]
var codigo_correcto = [1, 2, 8, 6]

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
	GameManager.puzzle_clave = true
	SoundManager.reproducir_efecto(6)
	var parent = self.get_parent()
	await get_tree().create_timer(1).timeout
	parent.visible = false
