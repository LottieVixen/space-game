extends Area2D

signal coin_collected

func _on_coin_body_entered(_body):
	set_collision_mask_bit(0,0)
	$AnimationPlayer.play("bounce")
	#body.add_coin()
	emit_signal("coin_collected")


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
