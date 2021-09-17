extends KinematicBody2D

var velocity = Vector2(0, 0)
var coins = 0
const SPEED = 360
const GRAVITY = 35
const JUMPFORCE = -1000

func _physics_process(_delta):
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	else:
		$Sprite.play("idle")
		
	if not is_on_floor():
		$Sprite.play("air")
	
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.1)


func _on_fallzone_body_entered(_body):
	# #warning-ignore:return_value_discarded
	var _err = get_tree().change_scene("res://levels/Level1.tscn")

func add_coin():
	coins += 1
