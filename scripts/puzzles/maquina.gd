extends TextureRect

@onready var btn_palanca = $btn_palanca
@onready var palanca = $btn_palanca/palanca

func _ready():
	if btn_palanca:
		btn_palanca.connect("pressed", Callable(self, "_on_palanca_pressed"))
	else:
		push_warning("No se encontró el nodo btn_palanca")

func _on_palanca_pressed():
	if palanca:
		palanca.visible = not palanca.visible
		SoundManager.reproducir_efecto(2)
	else:
		push_warning("No se encontró el nodo palanca")
