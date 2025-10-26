extends Node

var inventario : Array[Texture2D]
var objetos_recolectados : Array[String] = []
var transicion = 0
var puzzle_1 = false

func _ready():
	if inventario == null:
		inventario = []
		print("[GameManager] Inventario inicializado")
	else:
		print("GameManager] Inventario ya existente, preservando objetos:", inventario.size())

func agregar_objeto(texture: Texture2D) -> void:
	if texture == null:
		return
	
	var path = texture.resource_path
	inventario.append(texture)
	
	if not objetos_recolectados.has(path):
		objetos_recolectados.append(path)
	
	print("[GameManager] Objeto agregado:", path)

func obtener_inventario() -> Array[Texture2D]:
	return inventario.duplicate()
	
func obtener_recolectados() -> Array[String]:
	return objetos_recolectados.duplicate()

func debug_inventario():
	print("[GameManager] Inventario completo:")
	for i in range(inventario.size()):
		print("   Slot", i, ":", inventario[i])
