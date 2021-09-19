extends Node2D

onready var ship = $Ship
onready var debug = $debug

func _process(_delta):
	debug.get_node("container/vcontainer/stat1").text = "Ship Rotation: " + String(ship.rotation)
	debug.get_node("container/vcontainer/stat2").text = "Angular Velocity: " + String(ship.angular_velocity)
