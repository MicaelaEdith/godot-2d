extends TextureRect

var hojas: Array = []
var indice_actual: int = 0

@onready var hoja1 = $hoja1
@onready var hoja2 = $hoja2
@onready var hoja3 = $hoja3
@onready var hoja4 = $hoja4
@onready var hoja5 = $hoja5

@onready var btn_izquierda = $btn_izquierda
@onready var btn_derecha = $btn_derecha

func _ready():
	hojas = []
	hojas.append(hoja1)
	hojas.append(hoja2)
	hojas.append(hoja3)
	hojas.append(hoja4)
	hojas.append(hoja5)

	if btn_izquierda:
		btn_izquierda.connect("pressed", Callable(self, "_on_pagina_izquierda"))
	if btn_derecha:
		btn_derecha.connect("pressed", Callable(self, "_on_pagina_derecha"))

	indice_actual = 0
	_actualizar_hojas()


func _on_pagina_derecha():
	if indice_actual < hojas.size() - 1:
		indice_actual += 1
		_actualizar_hojas()
		SoundManager.reproducir_efecto(4)


func _on_pagina_izquierda():
	if indice_actual > 0:
		indice_actual -= 1
		_actualizar_hojas()
		SoundManager.reproducir_efecto(4)


func _actualizar_hojas():
	for i in range(hojas.size()):
		hojas[i].visible = (i == indice_actual)

	if btn_izquierda:
		btn_izquierda.disabled = (indice_actual == 0)
	if btn_derecha:
		btn_derecha.disabled = (indice_actual == hojas.size() - 1)
