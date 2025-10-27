extends Button

@export var puzzle_node_path: NodePath
var puzzle_node : Node = null

func _ready():
	if puzzle_node_path:
		puzzle_node = get_node(puzzle_node_path)

func _pressed():
	SoundManager.reproducir_efecto(2)
	if puzzle_node:
		puzzle_node.visible = false
