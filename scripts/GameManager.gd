extends Node

# Array que guarda todas las texturas de los objetos
var inventario : Array[Texture2D]

func _ready():
	if inventario == null:
		inventario = []
		print("[GameManager] Inventario inicializado")
	else:
		print("GameManager] Inventario ya existente, preservando objetos:", inventario.size())

# Función para agregar un objeto al inventario global
func agregar_objeto(texture: Texture2D) -> void:
	inventario.append(texture)
	print("[GameManager] Objeto agregado. Total objetos:", inventario.size())

# Función para obtener la copia del inventario
func obtener_inventario() -> Array[Texture2D]:
	print("[GameManager] Obtener inventario. Total objetos actualmente:", inventario.size())
	for i in range(inventario.size()):
		print("   -> Slot", i, ":", inventario[i])
	return inventario.duplicate()

# Función opcional para depuración rápida
func debug_inventario():
	print("[GameManager] Inventario completo:")
	for i in range(inventario.size()):
		print("   Slot", i, ":", inventario[i])
