extends Button

@export var puzzle_node_path: NodePath
var puzzle_node: Node = null

func _ready():
	if puzzle_node_path:
		puzzle_node = get_node(puzzle_node_path)

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SoundManager.reproducir_efecto(2)
		if puzzle_node:
			if puzzle_node.name == "puzzle1":
				if not GameManager.puzzle_1:
					puzzle_node.visible = true
			elif puzzle_node.name == "fondo-clave":
				if not GameManager.puzzle_clave:
					puzzle_node.visible = true
			else:
				puzzle_node.visible = true
