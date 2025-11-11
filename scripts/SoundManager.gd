extends Node

var sonidos : Array[AudioStream] = [
	preload("res://assets/audio/menu.mp3"),
	preload("res://assets/audio/backgound.mp3"),
	preload("res://assets/audio/boton.mp3"),
	preload("res://assets/audio/puerta.mp3"),
	preload("res://assets/audio/libreta.mp3"),
	preload("res://assets/audio/cuadro.mp3"),
	preload("res://assets/audio/ascensor.mp3"),
	preload("res://assets/audio/ascensor-sb.mp3"),
	preload("res://assets/audio/caja-fuerte.mp3")
]

var reproductor : AudioStreamPlayer
var sonido_activo : int = -1

var sonido_encendido : bool = true
var efectos_encendidos : bool = true

func _ready():
	reproductor = AudioStreamPlayer.new()
	reproductor.autoplay = false
	add_child(reproductor)
	print("[SoundManager] Iniciado. Sonidos cargados:", sonidos.size())

func reproducir_sonido(indice: int) -> void:
	if not sonido_encendido:
		print("[SoundManager] Música desactivada, no se reproduce nada.")
		return
	if indice < 0 or indice >= sonidos.size():
		push_error("[SoundManager] Índice inválido: " + str(indice))
		return

	var sonido = sonidos[indice]
	if sonido_activo == indice and reproductor.playing:
		return

	var stream_copy = sonido.duplicate() as AudioStream
	if stream_copy.has_method("set_loop"):
		stream_copy.set_loop(true)
	elif stream_copy is AudioStreamMP3:
		stream_copy.loop = true

	reproductor.stream = stream_copy
	reproductor.volume_db = 0
	reproductor.play()
	sonido_activo = indice
	print("[SoundManager] Reproduciendo sonido", indice)

func detener_sonido():
	if reproductor.playing:
		reproductor.stop()
		print("[SoundManager] Sonido detenido.")
	sonido_activo = -1
	
func toggle_musica():
	sonido_encendido = not sonido_encendido
	print("[SoundManager] Música encendida:", sonido_encendido)

	if not sonido_encendido:
		detener_sonido()
	else:
		var escena_actual = get_tree().current_scene
		if escena_actual:
			var nombre_escena = escena_actual.scene_file_path.get_file()
			print("[SoundManager] Escena actual:", nombre_escena)

			var indice_sonido = 0 if nombre_escena == "Menu.tscn" else 1
			reproducir_sonido(indice_sonido)
		else:
			if sonido_activo >= 0:
				reproducir_sonido(sonido_activo)
			else:
				reproducir_sonido(0)

func toggle_efectos():
	efectos_encendidos = not efectos_encendidos

func fade_out_tiempo(duracion: float = 2.0) -> void:
	if not reproductor.playing:
		return

	var tween = create_tween()
	tween.tween_property(reproductor, "volume_db", -80.0, duracion)
	tween.connect("finished", Callable(self, "_on_fade_out_completado"))

func _on_fade_out_completado():
	reproductor.stop()
	reproductor.volume_db = 0
	print("[SoundManager] Fade-out temporal completado")

	
func reproducir_efecto(indice: int) -> void:
	if not efectos_encendidos:
		print("[SoundManager] Efectos desactivados, no se reproduce nada.")
		return
	if indice < 0 or indice >= sonidos.size():
		push_error("[SoundManager] Índice inválido para efecto: " + str(indice))
		return

	var efecto = sonidos[indice]
	var player_temp = AudioStreamPlayer.new()
	player_temp.stream = efecto
	player_temp.autoplay = false
	player_temp.volume_db = reproductor.volume_db 
	add_child(player_temp)

	player_temp.play()
	print("[SoundManager] Reproduciendo efecto:", indice)

	player_temp.connect("finished", Callable(player_temp, "queue_free"))
