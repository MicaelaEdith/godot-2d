extends Node2D

func _ready():
	SoundManager.reproducir_sonido(1)
	_actualizar_luz()

func _process(_delta):
	_actualizar_luz()

func _actualizar_luz():
	if GameManager.luz_encendida:
		var imagen = get_child(0)
		var btn_clave = get_child(1)
		btn_clave = true
		if GameManager.puzzle_clave:
			imagen.texture = load("res://assets/fondos-escenas/scn1_d.png")
			print("[Capitulo1] Luz encendida")
		else:
			imagen.texture = load("res://assets/fondos-escenas/scn1_c.png")
			print("[Capitulo1] Luz encendida")
			
	else:
		var imagen = get_child(0)
		var btn_clave = get_child(1)
		btn_clave.visible = false
		if GameManager.puzzle_1:
			imagen.texture = load("res://assets/fondos-escenas/scn1_b.png")
			print("[Capitulo1] Luz apagada")
		else:
			imagen.texture = load("res://assets/fondos-escenas/scn1.png")
			print("[Capitulo1] Luz apagada")
