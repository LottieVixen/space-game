extends Camera2D


func _ready():
	pass

func _process(_delta):
	if Input.is_action_pressed("zoom_in"):
		zoom = Vector2(zoom.x - 0.01, zoom.y - 0.01)
	elif Input.is_action_pressed("zoom_out"):
		zoom = Vector2(zoom.x + 0.01, zoom.y + 0.01)
