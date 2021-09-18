extends RigidBody2D


var screensize

#thrust Vectors
export (float) var thruster_forces = 150
onready var half = thruster_forces / 2

onready var thrust_force = thruster_forces * Vector2.RIGHT
onready var thrust_rev = half * Vector2.LEFT
onready var thrust_up = half * Vector2.DOWN
onready var thrust_down = half * Vector2.UP

#controls
var forward = 0
var reverse = 0
var roll_left = 0
var roll_right = 0

func _ready():
	screensize = get_viewport().get_visible_rect().size
	#debug()

func _draw():
	draw_circle((to_local($Thrusters/Rear.global_position) + thrust_force),5,Color.rebeccapurple)
	#Draw vector for rear thruster #Issue
	draw_line(to_local($Thrusters/Rear.global_position),(
		to_local($Thrusters/Rear.global_position) + 
		thrust_force.rotated(global_rotation)
		),Color.red)
	draw_circle((to_local($Thrusters/Left/Forward.global_position) + thrust_rev),5,Color.rebeccapurple)
	draw_circle((to_local($Thrusters/Right/Forward.global_position) + thrust_rev),5,Color.rebeccapurple)
	#draw_circle((Vector2(0,0) + thrust_force),5,Color.rebeccapurple)

func _process(_delta):
	if Input.is_action_pressed("jump"):
		forward = 1
	else:
		forward = 0
	if Input.is_action_pressed("reverse_thrust"):
		reverse = 1
		$Thrusters/Left/Forward/highlight.visible = true
		$Thrusters/Right/Forward/highlight.visible = true
	else:
		reverse = 0
		$Thrusters/Left/Forward/highlight.visible = false
		$Thrusters/Right/Forward/highlight.visible = false
	if Input.is_action_pressed("roll_left"):
		roll_left = 1
		$Thrusters/Left/Rear/highlight.visible = true
		$Thrusters/Right/Front/highlight.visible = true
	else:
		roll_left = 0
		$Thrusters/Left/Rear/highlight.visible = false
		$Thrusters/Right/Front/highlight.visible = false
	if Input.is_action_pressed("roll_right"):
		roll_right = 1
		$Thrusters/Left/Front/highlight.visible = true
		$Thrusters/Right/Rear/highlight.visible = true
	else:
		roll_right = 0
		$Thrusters/Left/Front/highlight.visible = false
		$Thrusters/Right/Rear/highlight.visible = false
		
	$Thrusters/Rear/highlight.visible = bool(forward)

func _integrate_forces(_state):
	#if !centered:
	#	var xform = state.get_transform()
	#	xform.origin.x = screensize.x / 2
	#	xform.origin.y = screensize.y / 2
	#	state.set_transform(xform)
	#	centered = true
	#add_force($Thrusters/Rear.global_position, thrust_force * forward)
	#apply impulse vector for rear thruster #Issue
	apply_impulse(
		to_local($Thrusters/Rear.global_position),
		thrust_force.rotated(global_rotation) * forward
		)
	apply_impulse(to_local($Thrusters/Left/Forward.global_position), thrust_rev * reverse)
	apply_impulse(to_local($Thrusters/Right/Forward.global_position), thrust_rev * reverse)
	
	apply_impulse(to_local($Thrusters/Left/Rear.global_position), thrust_up * roll_left)
	apply_impulse(to_local($Thrusters/Right/Front.global_position), thrust_down * roll_left)
	
	apply_impulse(to_local($Thrusters/Left/Front.global_position), thrust_up * roll_right)
	apply_impulse(to_local($Thrusters/Right/Rear.global_position), thrust_down * roll_right)
	

func debug():
	print("local:" + String(to_local($Thrusters/Rear.global_position)))
	print("global:" + String($Thrusters/Rear.global_position))
