extends Button

@export var puzzle_node_path: NodePath
var puzzle_node : Node = null

func _ready():
	if puzzle_node_path:
		puzzle_node = get_node(puzzle_node_path)

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if puzzle_node:
			puzzle_node.visible = true
