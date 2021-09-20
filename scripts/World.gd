extends Node2D

onready var ship = $Ship
onready var debug = $debug

#drawing stuff
var array_points = PoolVector2Array()

func _draw():
	#for point in array_points:
	#	draw_circle(point,1,Color.black)
	pass

func _process(_delta):
	debug.get_node("container/vcontainer/stat1").text = "Ship Rotation: " + String(ship.rotation)
	debug.get_node("container/vcontainer/stat2").text = "Angular Velocity: " + String(ship.angular_velocity)
	debug.get_node("container/vcontainer/stat3").text = "Inertia: " + String(ship.inertia)
	
	#update()

func add_point(point_to_add:Vector2) -> void:
	array_points.append(point_to_add)
