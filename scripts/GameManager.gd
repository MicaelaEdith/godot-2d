extends Node

var inventario : Array[Texture2D] = []
var inventario_registrado : Array[String] = []
var objetos_recolectados : Array[String] = []
var transicion = 0
var puzzle_1 = false
var objeto_seleccionado = null

func _ready():
	print("[GameManager] Inventario inicializado")

func agregar_objeto(texture: Texture2D) -> void:
	if texture == null:
		return
	
	var path = texture.resource_path
	inventario.append(texture)
	
	if not objetos_recolectados.has(path):
		objetos_recolectados.append(path)
	
	if not inventario_registrado.has(path):
		inventario_registrado.append(path)
	
	print("[GameManager] Objeto agregado:", path)

func quitar_objeto(nombre_archivo: String) -> void:
	for i in range(inventario.size()):
		if inventario[i].resource_path.get_file() == nombre_archivo:
			print("[GameManager] Objeto quitado:", nombre_archivo)
			inventario.remove_at(i)
			if objeto_seleccionado == nombre_archivo:
				objeto_seleccionado = null
			return
	print("[GameManager] No se encontró el objeto a quitar:", nombre_archivo)

func obtener_inventario() -> Array[Texture2D]:
	return inventario.duplicate()

func obtener_recolectados() -> Array[String]:
	return objetos_recolectados.duplicate()

func obtener_inventario_registrado() -> Array[String]:
	return inventario_registrado.duplicate()

func debug_inventario():
	print("[GameManager] Inventario completo:")
	for i in range(inventario.size()):
		print("   Slot", i, ":", inventario[i])
