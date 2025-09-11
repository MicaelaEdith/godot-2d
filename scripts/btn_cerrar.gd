extends Button

export(NodePath) var puzzle_node_path
var puzzle_node : Node = null

func _ready():
	if puzzle_node_path:
		puzzle_node = get_node(puzzle_node_path)

func _pressed():
	if puzzle_node:
		puzzle_node.visible = false
