extends Node


func _ready():
	connect("pressed", Callable(self, "_pressed"))
	
func _pressed():
	GameManager.texto_label = "Solo es una inerte barra de carbón"
