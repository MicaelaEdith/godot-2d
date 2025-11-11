extends Node2D

func _ready():
	SoundManager.reproducir_sonido(1)
	_actualizar_luz()

func _process(_delta):
	_actualizar_luz()

func _actualizar_luz():
	if GameManager.luz_encendida and not GameManager.cables_cortados:
		var imagen = get_child(0)
		var btn_clave = get_child(1)
		btn_clave = true
		if GameManager.puzzle_clave:
			imagen.texture = load("res://assets/fondos-escenas/scn1_d.png")
		else:
			imagen.texture = load("res://assets/fondos-escenas/scn1_c.png")
			
	else:
		var imagen = get_child(0)
		var btn_clave = get_child(1)
		btn_clave.visible = false
		if GameManager.puzzle_1:
			imagen.texture = load("res://assets/fondos-escenas/scn1_b.png")
		else:
			imagen.texture = load("res://assets/fondos-escenas/scn1.png")
