extends Node
func _ready():
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	SoundManager.reproducir_efecto(4)
	if self.text == "  >  ":
		print("pagina_derecha")
	else:
		print("pagina_izquierda")
