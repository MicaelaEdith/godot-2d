extends TextureRect

@onready var boton_musica = $BotonMusica
@onready var boton_efectos = $BotonEfectos
@onready var boton_cerrar = $BotonCerrar
@onready var sound_manager = get_node("/root/SoundManager")

@export var nodo_a_mostrar: NodePath

var color_apagado = Color("020201b4")
var color_normal = Color(1, 1, 1, 0)

func _ready():
	boton_musica.pressed.connect(_on_boton_musica_pressed)
	boton_efectos.pressed.connect(_on_boton_efectos_pressed)
	boton_cerrar.pressed.connect(_on_boton_cerrar_pressed)
	actualizar_colores()


func _on_boton_musica_pressed():
	sound_manager.reproducir_efecto(2)
	sound_manager.toggle_musica()
	actualizar_colores()

func _on_boton_efectos_pressed():
	sound_manager.reproducir_efecto(2)
	sound_manager.toggle_efectos()
	actualizar_colores()

func _on_boton_cerrar_pressed():
	sound_manager.reproducir_efecto(2)
	var nodo = get_node_or_null(nodo_a_mostrar)
	if nodo:
		nodo.visible = false
	else:
		self.visible = false

func actualizar_colores():
	var estilo_musica = StyleBoxFlat.new()
	estilo_musica.bg_color = color_normal if sound_manager.sonido_encendido else color_apagado
	estilo_musica.corner_radius_top_left = 6
	estilo_musica.corner_radius_top_right = 6
	estilo_musica.corner_radius_bottom_left = 6
	estilo_musica.corner_radius_bottom_right = 6
	boton_musica.add_theme_stylebox_override("normal", estilo_musica)

	var estilo_efectos = StyleBoxFlat.new()
	estilo_efectos.bg_color = color_normal if sound_manager.efectos_encendidos else color_apagado
	estilo_efectos.corner_radius_top_left = 6
	estilo_efectos.corner_radius_top_right = 6
	estilo_efectos.corner_radius_bottom_left = 6
	estilo_efectos.corner_radius_bottom_right = 6
	boton_efectos.add_theme_stylebox_override("normal", estilo_efectos)
