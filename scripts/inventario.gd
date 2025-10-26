extends VBoxContainer

func _ready():
	cargar_inventario()

func agregar_objeto(texture: Texture2D) -> void:
	GameManager.agregar_objeto(texture)

	for slot in get_children():
		if slot.has_node("Icono"):
			var icono = slot.get_node("Icono")
			if icono.texture == null:
				icono.texture = texture
				return

func cargar_inventario() -> void:
	var items = GameManager.obtener_inventario()
	var slots = []

	for child in get_children():
		if child is Button:
			slots.append(child)
	
	for i in range(min(items.size(), slots.size())):
		var slot = slots[i]
		if slot.has_node("Icono"):
			var icono = slot.get_node("Icono")
			icono.texture = items[i]
