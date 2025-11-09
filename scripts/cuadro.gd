extends Button

var activo := false
var posicion_inicial := Vector2.ZERO
var escala_inicial := Vector2.ONE

func _ready():
	posicion_inicial = position
	escala_inicial = scale
	connect("pressed", Callable(self, "_on_cuadro_pressed"))

func _on_cuadro_pressed():
	SoundManager.reproducir_efecto(5)
	if not activo:
		_mover_y_agrandar()
	else:
		_volver_a_posicion()
	activo = not activo


func _mover_y_agrandar():
	var desplazamiento = Vector2(-size.x - 130, 0)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

	tween.tween_property(self, "scale", escala_inicial * 1.03, 0.20)
	tween.tween_callback(func(): _desplazar(desplazamiento))


func _desplazar(desplazamiento: Vector2):
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", posicion_inicial + desplazamiento, 0.25)


func _volver_a_posicion():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	tween.tween_property(self, "scale", escala_inicial, 0.25)
	tween.tween_callback(func(): _volver_posicion_final())


func _volver_posicion_final():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", posicion_inicial, 0.25)
