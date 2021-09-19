extends MarginContainer

export (NodePath) var TargetPath

onready var TargetNode = get_node(TargetPath)
onready var StartOffset = rect_position - TargetNode.position

func _process(_delta):
	rect_position = TargetNode.position + StartOffset
