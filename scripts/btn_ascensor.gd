extends Button

@onready var transicion := $TransicionAscensor

var imagenes := [
	preload("res://assets/fondos-escenas/transiciones/03.png"),
	preload("res://assets/fondos-escenas/transiciones/04.png"),
	preload("res://assets/fondos-escenas/transiciones/05.png"),
	preload("res://assets/fondos-escenas/transiciones/06.png"),
	preload("res://assets/fondos-escenas/transiciones/07.png"),
	preload("res://assets/fondos-escenas/transiciones/08.png"),
	preload("res://assets/fondos-escenas/transiciones/09.png")
]

func _ready():
	self.focus_mode = Control.FOCUS_NONE
	self.visible = true
	connect("pressed", Callable(self, "_on_pressed"))
	transicion.visible = false

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

	if nombre == "scn1_d":
		await _iniciar_transicion()

func _iniciar_transicion():
	transicion.visible = true
	SoundManager.reproducir_efecto(7)
	GameManager.texto_label = "Finalmente sabré qué guardaba el doctor ahí arriba"

	for i in imagenes.size():
		transicion.texture = imagenes[i]
		await get_tree().create_timer(0.4).timeout

	_cargar_capitulo3()

func _cargar_capitulo3():
	var nueva_escena = load("res://Capitulo3.tscn")
	get_tree().change_scene_to_packed(nueva_escena)
