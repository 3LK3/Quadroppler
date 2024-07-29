@tool
@icon("res://assets/icons/Piece_00.svg")
class_name PieceData
extends Resource
## Data representation of a piece.
##
## Contains tile patterns (one for each rotation).

@export var color: Color
  
## One tile pattern for each rotation of the piece
@export var rotation_states: Array[PieceRotationState]:
	get:
		return _rotation_states
	set(value):
		_rotation_states = value
		if _rotation_states.size() > 0:
			_active_rotation_state = 0

var _rotation_states: Array[PieceRotationState]
var _active_rotation_state: int = -1

func rotate() -> void:
	_active_rotation_state = get_next_rotation_state()

func get_active_rotation_state() -> PieceRotationState:
	return _rotation_states[_active_rotation_state]

func get_next_rotation_state() -> int:
	var next: int = _active_rotation_state + 1
	if next == _rotation_states.size():
		return 0
	return next

func get_coordinates() -> Array[Vector2i]:
	return _rotation_states[_active_rotation_state].coordinates

func get_bounding_box_size() -> Vector2i:
	return _rotation_states[_active_rotation_state].bounding_box_size
