extends VBoxContainer

func _ready():
	cargar_inventario()

func agregar_objeto(texture: Texture2D) -> void:
	GameManager.agregar_objeto(texture)

	for slot in get_children():
		if slot.has_node("Icono"):
			if slot.icono.texture == null:
				slot.set_icon(texture)
				print("Objeto agregado al inventario visual en slot:", slot.name)
				return

func cargar_inventario() -> void:
	var items = GameManager.obtener_inventario()

	var slots = []
	for child in get_children():
		if child is Button:
			slots.append(child)
	
	print("[InventarioUI] Cargando inventario en UI, slots válidos:", slots.size(), " | Objetos:", items.size())
	
	for i in range(min(items.size(), slots.size())):
		var slot = slots[i]
		if slot.has_node("Icono"):
			slot.set_icon(items[i])
			print("[InventarioUI] Slot", slot.name, "recibe objeto:", items[i])
