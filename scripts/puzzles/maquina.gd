extends TextureRect

@onready var btn_palanca = $btn_palanca
@onready var palanca = $btn_palanca/palanca
@onready var luz = $btn_palanca/luz

func _ready():
	if btn_palanca:
		btn_palanca.connect("pressed", Callable(self, "_on_palanca_pressed"))
	else:
		push_warning("No se encontró el nodo btn_palanca")

func _on_palanca_pressed(): # arreglar vuelta al capitulo 1
	if palanca:
		palanca.visible = not palanca.visible
		SoundManager.reproducir_efecto(2)
		GameManager.luz_encendida = not GameManager.luz_encendida
		if GameManager.luz_encendida:
			luz.visible = true
		else:
			luz.visible = false
	else:
		push_warning("No se encontró el nodo palanca")
