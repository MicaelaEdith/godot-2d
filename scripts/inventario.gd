extends VBoxContainer

func _ready():
	cargar_inventario()

# Función para agregar un objeto desde el juego
func agregar_objeto(texture: Texture2D) -> void:
	# Agregamos al GameManager
	GameManager.agregar_objeto(texture)

	# Ahora lo mostramos en la UI
	for slot in get_children():
		if slot.has_node("Icono"):
			if slot.icono.texture == null:
				slot.set_icon(texture)
				print("Objeto agregado al inventario visual en slot:", slot.name)
				return  # solo ocupamos un slot vacío

# Cargar inventario desde el GameManager al iniciar la escena
func cargar_inventario() -> void:
	var items = GameManager.obtener_inventario()
	var slots = get_children()
	print("🖼 [InventarioUI] Cargando inventario en UI, slots disponibles:", slots.size())
	for i in range(min(items.size(), slots.size())):
		var slot = slots[i]
		if slot.has_node("Icono"):
			slot.set_icon(items[i])
			print("🖼 [InventarioUI] Slot", slot.name, "recibe objeto:", items[i])
 
