extends RigidBody2D

var yAxis = 0.0
var xAxis = 0.0
var rb

func _ready():
	rb = get_node("/root")

func ClampVelocity():
	pass

func ThrustForward(amount):
	var force
	force = Vector2.UP * amount
	
func _integrate_forces(state):
	pass

func _process(delta):
	yAxis = 0
	xAxis = 0
	
	if Input.is_action_pressed("up"):
		yAxis = -1
	elif Input.is_action_pressed("down"):
		yAxis = 1
	
	if Input.is_action_pressed("right"):
		xAxis = 1
	elif Input.is_action_pressed("left"):
		xAxis = -1
	
func _physics_process(delta):
	pass
