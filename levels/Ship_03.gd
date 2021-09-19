extends RigidBody2D

#thrust Vectors
export (float) var thruster_forces = 150
onready var half = thruster_forces / 2

onready var thrust_force = thruster_forces * Vector2.RIGHT
onready var thrust_rev = half * Vector2.LEFT
onready var thrust_up = half * Vector2.DOWN
onready var thrust_down = half * Vector2.UP

#thruster offsets
onready var rear_thruster_offset = to_local($Thrusters/Rear.global_position)

#debug
var break_this_time = false

#controls
var forward = 0
var reverse = 0
var roll_left = 0
var roll_right = 0
var strafe_left = 0
var strafe_right = 0

func _draw():
	draw_circle((thrust_force.rotated(rotation)),5,Color.rebeccapurple)
	draw_line($Thrusters/Rear.position,($Thrusters/Rear.position + thrust_force.rotated(rotation)*50),Color.red)
	draw_circle(($Thrusters/Left/Forward.position + thrust_rev.rotated(rotation)*50),5,Color.rebeccapurple)
	#get_node("../").add_point( to_global($Thrusters/Left/Forward.global_position + thrust_rev.rotated(rotation)) )
	draw_circle(($Thrusters/Right/Forward.position + thrust_rev.rotated(rotation)*50),5,Color.rebeccapurple)
	draw_arc(Vector2.ZERO, 10, 0, angular_velocity, 32, Color.red, 10, false)

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
	if Input.is_action_pressed("left"):
		strafe_left = 1
		$Thrusters/Right/Mid/highlight.visible = true
	else:
		strafe_left = 0
		$Thrusters/Right/Mid/highlight.visible = false
	if Input.is_action_pressed("right"):
		strafe_right = 1
		$Thrusters/Left/Mid/highlight.visible = true
	else:
		strafe_right = 0
		$Thrusters/Left/Mid/highlight.visible = false
	$Thrusters/Rear/highlight.visible = bool(forward)
	
	if Input.is_action_pressed("breakpoint_trigger"):
		break_this_time = true
		
	update()

func _integrate_forces(_state):
	apply_impulse($Thrusters/Rear.position, thrust_force.rotated(rotation) * forward) #has a slight clockwise spin
	#apply_central_impulse(thrust_force.rotated(rotation) * forward) #works as expected, flies straight at the ship's heading
	if break_this_time:
		break_this_time = false
		#print("\nto:    " + String(angle_to_root/PI) + "\nfrom: " + String(angle_from_root/PI) + "\nunit:  " + String(unit_angle/PI))
		print("pos: "+ String($Thrusters/Left/Front.position))
		print("loc: "+ String(self.to_local($Thrusters/Left/Front.global_position)))
		pass
	#Reverse
	apply_impulse($Thrusters/Left/Forward.position.normalized(), thrust_rev.rotated(global_rotation) * reverse)
	apply_impulse($Thrusters/Right/Forward.position.normalized(), thrust_rev.rotated(global_rotation)  * reverse)
	#Roll Left
	apply_impulse($Thrusters/Left/Rear.position, thrust_up * roll_left)
	apply_impulse($Thrusters/Right/Front.position, thrust_down * roll_left)
	#Roll Right
	apply_impulse($Thrusters/Left/Front.position, thrust_up * roll_right)
	apply_impulse($Thrusters/Right/Rear.position, thrust_down * roll_right)
	#Strafe left
	apply_impulse($Thrusters/Right/Mid.position.normalized(), thrust_down.rotated(global_rotation) * strafe_left)
	#Strafe right
	apply_impulse($Thrusters/Left/Mid.position.normalized(), thrust_up.rotated(global_rotation) * strafe_right)

func debug():
	print("local:" + String(to_local($Thrusters/Rear.global_position)))
	print("global:" + String($Thrusters/Rear.global_position))
