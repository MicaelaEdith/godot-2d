extends VBoxContainer

func _ready():
	cargar_inventario()
	conectar_slots()

func conectar_slots() -> void:
	for slot in get_children():
		if slot is Button:
			slot.connect("toggled", Callable(self, "_on_slot_toggled").bind(slot))

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
	var slots: Array = []

	for child in get_children():
		if child is Button:
			slots.append(child)

	for slot in slots:
		if slot.has_node("Icono"):
			var icono = slot.get_node("Icono")
			icono.texture = null

	for i in range(min(items.size(), slots.size())):
		var slot = slots[i]
		if slot.has_node("Icono"):
			var icono = slot.get_node("Icono")
			icono.texture = items[i]

func _on_slot_toggled(pressed: bool, slot: Button) -> void:
	if not slot.has_node("Icono"):
		slot.button_pressed = false
		return
	
	var icono = slot.get_node("Icono")
	if icono.texture == null:
		slot.button_pressed = false
		return

	if pressed:
		for other in get_children():
			if other is Button and other != slot:
				other.button_pressed = false
		
		GameManager.objeto_seleccionado = icono.texture.resource_path.get_file()
		print("[Inventario] Objeto seleccionado:", GameManager.objeto_seleccionado)
	else:
		GameManager.objeto_seleccionado = null
		print("[Inventario] Ningún objeto seleccionado")
		
func quitar_objeto(nombre_archivo: String) -> void:
	GameManager.quitar_objeto(nombre_archivo)

	for slot in get_children():
		if slot.has_node("Icono"):
			var icono = slot.get_node("Icono")
			if icono.texture and icono.texture.resource_path.get_file() == nombre_archivo:
				icono.texture = null
				slot.button_pressed = false
				break
	
	cargar_inventario()
