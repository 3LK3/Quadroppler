#class_name PieceDefinitionSystem
extends Node

signal next_piece_set(next_piece: PieceData)

@export var pieces: Array[PieceData]

var _random_bag: Array[PieceData]
var _next_piece: PieceData = null
var _random = RandomNumberGenerator.new()

func get_random_piece() -> PieceData:
	if _random_bag.is_empty():
		print("Refill random bag")
		_random_bag.append_array(pieces.map(func(p): return p.duplicate()))
	return _random_bag.pop_at(_random.randi_range(0, _random_bag.size() - 1))
	
func get_next_piece() -> PieceData:
	return _next_piece

func set_next_piece() -> void:
	_next_piece = get_random_piece()
	next_piece_set.emit(_next_piece)
