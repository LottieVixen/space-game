extends RigidBody2D


var screensize

#thrust Vectors
export (Vector2) var thrust_force = Vector2(15,0)
var thrust_rev = Vector2(-7.5,0)
var thrust_up = Vector2(0,7.5)
var thrust_down = Vector2(0,-7.5)

#controls
var forward = 0
var reverse = 0
var roll_left = 0
var roll_right = 0

func _ready():
	screensize = get_viewport().get_visible_rect().size
	debug()

func _draw():
	draw_circle((to_local($Thrusters/Rear.global_position) + thrust_force),5,Color.rebeccapurple)
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
	else:
		reverse = 0
	if Input.is_action_pressed("roll_left"):
		roll_left = 1
	else:
		roll_left = 0
	if Input.is_action_pressed("roll_right"):
		roll_right = 1
	else:
		roll_right = 0

func _integrate_forces(_state):
	#if !centered:
	#	var xform = state.get_transform()
	#	xform.origin.x = screensize.x / 2
	#	xform.origin.y = screensize.y / 2
	#	state.set_transform(xform)
	#	centered = true
	#add_force($Thrusters/Rear.global_position, thrust_force * forward)
	apply_impulse(to_local($Thrusters/Rear.global_position), thrust_force * forward)
	apply_impulse(to_local($Thrusters/Left/Forward.global_position), thrust_rev * reverse)
	apply_impulse(to_local($Thrusters/Right/Forward.global_position), thrust_rev * reverse)
	
	apply_impulse(to_local($Thrusters/Left/Rear.global_position), thrust_up * roll_left)
	apply_impulse(to_local($Thrusters/Right/Front.global_position), thrust_down * roll_left)
	
	apply_impulse(to_local($Thrusters/Left/Front.global_position), thrust_up * roll_right)
	apply_impulse(to_local($Thrusters/Right/Rear.global_position), thrust_down * roll_right)
	

func debug():
	print("local:" + String(to_local($Thrusters/Rear.global_position)))
	print("global:" + String($Thrusters/Rear.global_position))
