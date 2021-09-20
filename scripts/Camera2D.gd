extends Camera2D

export (NodePath) var TargetPath

onready var TargetNode = get_node(TargetPath)
onready var StartOffset = position - TargetNode.position

func _process(_delta):
	if Input.is_action_pressed("zoom_in"):
		zoom = Vector2(zoom.x - 0.01, zoom.y - 0.01)
	elif Input.is_action_pressed("zoom_out"):
		zoom = Vector2(zoom.x + 0.01, zoom.y + 0.01)
	position = TargetNode.position + StartOffset
