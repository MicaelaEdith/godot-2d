extends TextureRect

@onready var btn_palanca = $btn_palanca
@onready var palanca = $btn_palanca/palanca
@onready var luz = $btn_palanca/luz

func _ready():
	if btn_palanca:
		btn_palanca.connect("pressed", Callable(self, "_on_palanca_pressed"))
	else:
		push_warning("No se encontró el nodo btn_palanca")
	
	if GameManager.cables_cortados == false:
		if GameManager.luz_encendida:
			luz.visible = true
		else:
			luz.visible = false

func _on_palanca_pressed():
	if palanca:
		palanca.visible = not palanca.visible
		SoundManager.reproducir_efecto(2)
		if GameManager.cables_cortados:
			GameManager.texto_label = "¿Cómo lo podré hacer funcionar?"
		GameManager.luz_encendida = not GameManager.luz_encendida
		if GameManager.luz_encendida and not GameManager.cables_cortados:
			luz.visible = true
		else:
			luz.visible = false
	else:
		push_warning("No se encontró el nodo palanca")
