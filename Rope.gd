extends CanvasItem

var RopePiece = preload("res://levels/RopePiece.tscn")
var piece_length := 4.0
var rope_parts := []
var rope_close_tolerance := 4.0
var rope_points := []

onready var rope_start_piece = $RopeStartPiece
onready var rope_end_piece = $RopeEndPiece
onready var rope_start_joint =$RopeStartPiece/C/J
onready var rope_end_joint =$RopeEndPiece/C/J


func _process(_delta):
	get_rope_points()
	if !rope_points.empty():
		#update
		pass


func spawn_rope(start_pos:Vector2, end_pos:Vector2):
	rope_start_piece.global_position = start_pos
	rope_end_piece.global_position = end_pos
	start_pos = rope_start_joint.global_position
	end_pos = rope_end_joint.global_position
	
	
	var distance = start_pos.distance_to(end_pos)
	var pieces_amount = round(distance / piece_length)
	var spawn_angle = (start_pos-end_pos).angle() + PI/2
	
	create_rope(pieces_amount, rope_start_piece, end_pos, spawn_angle)


func create_rope(pieces_amount:int, parent:Object, end_pos:Vector2, spawn_angle:float) -> void:
	for i in pieces_amount:
		parent = add_piece(parent, i, spawn_angle)
		parent.set_name("rope_piece_"+str(i))
		rope_parts.append(parent)
		
		var joint_pos = parent.get_node("C/J").global_position
		if joint_pos.distance_to(end_pos) < rope_close_tolerance:
			break
	
	rope_end_joint.node_a = rope_end_piece.get_path()
	rope_end_joint.node_b = rope_parts[-1].get_path()

func add_piece(parent:Object, id:int, spawn_angle:float) -> Object:
	var joint : PinJoint2D = parent.get_node("C/J") as PinJoint2D
	var piece : Object = RopePiece.instance() as Object
	piece.global_position = joint.global_position
	piece.rotation = spawn_angle
	piece.parent = self
	piece.id = id
	add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece

func get_rope_points() -> void:
	rope_points.clear()
	rope_points.append(rope_start_joint.global_position)
	for r in rope_parts:
		rope_points.append( r.global_position)
	rope_points.append(rope_end_joint.global_position)

func _draw():
	pass
