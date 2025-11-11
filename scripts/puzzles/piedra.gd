extends Node

func _ready() -> void:
	actualizar_estado()
	
func _process(delta: float) -> void:
	actualizar_estado()
	
func actualizar_estado():
	if GameManager.caja_fuerte:
		var borrar = false
		for i in range(GameManager.inventario.size()):
			if GameManager.inventario[i].resource_path.get_file() == "piedra.png":
				borrar = true
		
		if borrar:
			self.visible = false
		else:
			self.visible = true
