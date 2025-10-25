extends Node

var inventario : Array[Texture2D]
var transicion = 0

func _ready():
	if inventario == null:
		inventario = []
		print("[GameManager] Inventario inicializado")
	else:
		print("GameManager] Inventario ya existente, preservando objetos:", inventario.size())

func agregar_objeto(texture: Texture2D) -> void:
	inventario.append(texture)
	print("[GameManager] Objeto agregado. Total objetos:", inventario.size())

func obtener_inventario() -> Array[Texture2D]:
	print("[GameManager] Obtener inventario. Total objetos actualmente:", inventario.size())
	for i in range(inventario.size()):
		print("   -> Slot", i, ":", inventario[i])
	return inventario.duplicate()

func debug_inventario():
	print("[GameManager] Inventario completo:")
	for i in range(inventario.size()):
		print("   Slot", i, ":", inventario[i])
