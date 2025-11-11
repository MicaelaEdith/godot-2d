extends Panel

@onready var panel: Panel = self
@onready var label: Label = $Label

func _ready():
	panel.visible = false

func _process(_delta):
	if GameManager.texto_label != label.text and GameManager.texto_label != "":
		label.text = GameManager.texto_label
		panel.visible = true
		var tiempo = 2.5

		if GameManager.texto_label == "Quizás haya algo más abajo":
			tiempo = 2
			
		await get_tree().create_timer(tiempo).timeout
		panel.visible = false
		label.text = ""
		GameManager.texto_label = ""
