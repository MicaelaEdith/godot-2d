extends Panel

@onready var panel: Panel = self
@onready var label: Label = $Label

func _ready():
	panel.visible = false

func _process(_delta):
	if GameManager.texto_label != label.text and GameManager.texto_label != "":
		label.text = GameManager.texto_label
		panel.visible = true

		await get_tree().create_timer(2.5).timeout
		panel.visible = false
		label.text = ""
		GameManager.texto_label = ""
