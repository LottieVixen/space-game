extends CanvasLayer

var coins = 0

func _ready():
	$Coins.text = String(coins)

func _physics_process(_delta):
	if coins == 4:
		# #warning-ignore:return_value_discarded
		var _err =  get_tree().change_scene("res://levels/Level1.tscn")

func _on_coin_collected():
	coins += 1
	_ready()
