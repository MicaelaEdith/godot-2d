extends VBoxContainer

func agregar_objeto(texture: Texture2D):
	for slot in get_children():
		if slot.has_node("Icono"):		
			if slot.icono.texture == null:   
				slot.set_icon(texture)
				print("✅ Objeto agregado al inventario en slot:", slot.name)
				return


