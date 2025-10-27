extends Node

var sonidos : Array[AudioStream] = [
	preload("res://assets/audio/menu.mp3"),
	preload("res://assets/audio/backgound.mp3")
]

var reproductor : AudioStreamPlayer
var sonido_activo : int = -1
var sonido_encendido : bool = true

func _ready():
	reproductor = AudioStreamPlayer.new()
	reproductor.autoplay = false
	add_child(reproductor)
	print("[SoundManager] Iniciado. Sonidos cargados:", sonidos.size())

func reproducir_sonido(indice: int) -> void:
	if not sonido_encendido:
		print("[SoundManager] Sonido desactivado, no se reproduce nada.")
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
	reproductor.play()
	sonido_activo = indice
	print("[SoundManager] Reproduciendo sonido", indice)

func detener_sonido():
	if reproductor.playing:
		reproductor.stop()
		print("[SoundManager] Sonido detenido.")
	sonido_activo = -1

func toggle_sonido():
	sonido_encendido = not sonido_encendido
	print("[SoundManager] Sonido encendido:", sonido_encendido)

	if not sonido_encendido:
		detener_sonido()
	elif sonido_activo >= 0:
		reproducir_sonido(sonido_activo)
		
		
func fade_out_tiempo(duracion: float = 2.0) -> void:
	if not reproductor.playing:
		return

	var tween = create_tween()
	tween.tween_property(reproductor, "volume_db", -80.0, duracion)
	tween.connect("finished", Callable(self, "_on_fade_out_completado"))

func _on_fade_out_completado():
	reproductor.stop()
	reproductor.volume_db = 1
	print("[SoundManager] Fade-out temporal completado")
