extends Button

func _ready():
	self.focus_mode = Control.FOCUS_NONE
	self.visible = true
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	var capitulo = get_parent()
	if not capitulo or not capitulo.has_node("imgFondo"):
		return

	var imgfondo = capitulo.get_node("imgFondo")
	var textura_actual = imgfondo.texture
	if textura_actual == null:
		return

	var ruta = textura_actual.resource_path
	var nombre = ruta.get_file().get_basename()

	if nombre == "scn1_b" or nombre == "scn1_c":
		_cargar_capitulo2()

func _cargar_capitulo2():
	var nueva_escena = load("res://Capitulo2.tscn")
	get_tree().change_scene_to_packed(nueva_escena)
